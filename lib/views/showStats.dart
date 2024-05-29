import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Database.dart';
import '../models/Bac.dart';
import '../models/Espece.dart';

class ShowStats extends StatefulWidget {
  @override
  _ShowStatsState createState() => _ShowStatsState();
}

class _ShowStatsState extends State<ShowStats> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  int? _selectedEspeceId = null;
  int? _selectedYear = DateTime.now().year;

  late DateTime now = DateTime.now();
  late DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  late DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
  late String startOfWeekFormatted = startOfWeek.toIso8601String().split('T')[0];
  late String endOfWeekFormatted = endOfWeek.toIso8601String().split('T')[0];

  Map<int, int> _monthlyFishingDays = {};

  @override
  void initState() {
    super.initState();
    _calculateFishingDays();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  void _calculateFishingDays() async {
    final bacs = await _databaseHelper.getBacsForYear(_selectedYear!);
    _monthlyFishingDays = {};
    List<String> _datesCounted = [];
    for (var bac in bacs) {
      final month = bac.datePeche.month;
      final day = bac.datePeche.day;
      final date = '$day-$month';
      if (!_datesCounted.contains(date)) {
        _datesCounted.add(date);
        _monthlyFishingDays.update(month, (value) => value + 1, ifAbsent: () => 1);
      }
    }
    setState(() {});
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Statistiques Bacs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Semaine du $startOfWeekFormatted au $endOfWeekFormatted',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Espece',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder<List<Espece>>(
                        future: _databaseHelper.getEspeces(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return DropdownButtonFormField<int?>(
                              value: _selectedEspeceId,
                              onChanged: (int? newValue) {
                                setState(() {
                                  _selectedEspeceId = newValue;
                                });
                              },
                              validator: (int? value) {
                                if (value == null) {
                                  return 'Veuillez sélectionner une Espece';
                                }
                                return null;
                              },
                              items: [
                                DropdownMenuItem<int?>(
                                  value: null,
                                  child: Text(''),
                                ),
                                ...snapshot.data!.map<DropdownMenuItem<int?>>((Espece item) {
                                  return DropdownMenuItem<int?>(
                                    value: item.id,
                                    child: Text(item.nom),
                                  );
                                }).toList(),
                              ],
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: FutureBuilder<List<Bac>>(
                          future: _selectedEspeceId != null ? _databaseHelper.getBacsForEspeceByWeek(_selectedEspeceId!) : Future.value([]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final dailyTotals = <DateTime, int>{};
                              for (var bac in snapshot.data!) {
                                final date = DateTime(bac.datePeche.year, bac.datePeche.month, bac.datePeche.day);
                                dailyTotals.update(date, (value) => value + 1, ifAbsent: () => 1);
                              }

                              return ListView.builder(
                                itemCount: dailyTotals.length,
                                itemBuilder: (context, index) {
                                  final date = dailyTotals.keys.elementAt(index);
                                  final total = dailyTotals[date]!;
                                  return ListTile(
                                    title: Text('${capitalize(DateFormat('EEEE d MMMM', 'fr_FR').format(date))}: $total bacs'),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Année',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      DropdownButtonFormField<int>(
                        value: _selectedYear,
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedYear = newValue;
                            _calculateFishingDays();
                          });
                        },
                        items: List<int>.generate(DateTime.now().year - 2000 + 1, (i) => 2000 + i)
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value'),
                          );
                        }).toList(),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _monthlyFishingDays.length,
                          itemBuilder: (context, index) {
                            final month = _monthlyFishingDays.keys.elementAt(index);
                            final monthName = DateFormat('MMMM', 'fr_FR').format(DateTime(DateTime.now().year, month));
                            final fishingDays = _monthlyFishingDays[month]!;
                            final totalDaysInMonth = DateTime(DateTime.now().year, month + 1, 0).day;
                            final percentage = (fishingDays / totalDaysInMonth) * 100;
                            return ListTile(
                              title: Text('${capitalize(monthName)}: $fishingDays jours de pêche (${percentage.toStringAsFixed(2)}%)'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
