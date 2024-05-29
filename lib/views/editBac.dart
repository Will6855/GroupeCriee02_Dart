import 'package:flutter/material.dart';

import '../models/Bac.dart';
import '../models/Espece.dart';
import '../models/Taille.dart';
import '../models/Qualite.dart';
import '../models/Presentation.dart';
import '../models/TypeBac.dart';

import '../models/Database.dart';


class EditBac extends StatefulWidget {
  final int bacId;

  EditBac({required this.bacId});

  @override
  _EditBacState createState() => _EditBacState();
}

class _EditBacState extends State<EditBac> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  int? _selectedEspeceId = null;
  int? _selectedTailleId = null;
  String? _selectedQualiteId = null;
  String? _selectedPresentationId = null;
  String? _selectedTypeBacId = null;
  late DateTime _datePeche;

  @override
  void initState() {
    super.initState();
    _fetchBacData();
  }

  void _fetchBacData() async {
    final bac = await _databaseHelper.getBacById(widget.bacId);
    if (bac != null) {
      setState(() {
        _selectedEspeceId = bac.idEspece;
        _selectedTailleId = bac.idTaille;
        _selectedQualiteId = bac.idQualite;
        _selectedPresentationId = bac.idPresentation;
        _selectedTypeBacId = bac.idTypeBac;
        _datePeche = bac.datePeche;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Modifier Bac'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Espece',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              FutureBuilder<List<Espece>>(
                future: _databaseHelper.getEspeces(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Espece> especes = snapshot.data ?? [];
                    return DropdownButtonFormField<int?>(
                      value: _selectedEspeceId != null && especes.any((item) => item.id == _selectedEspeceId) ? _selectedEspeceId : null,
                      onChanged: (int? newValue) {
                        setState(() {
                          print('Espece ID selected: $newValue');
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


              const Text(
                'Taille',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              FutureBuilder<List<Taille>>(
                future: _databaseHelper.getTailles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Taille> tailles = snapshot.data ?? [];
                    return DropdownButtonFormField<int?>(
                      value: _selectedTailleId != null && tailles.any((item) => item.id == _selectedTailleId) ? _selectedTailleId : null,
                      onChanged: (int? newValue) {
                        setState(() {
                          print('Taille ID selected: $newValue');
                          _selectedTailleId = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<int?>(
                          value: null,
                          child: Text(''),
                        ),
                        ...snapshot.data!.map<DropdownMenuItem<int?>>((Taille item) {
                          return DropdownMenuItem<int?>(
                            value: item.id,
                            child: Text(item.specification),
                          );
                        }).toList(),
                      ],
                    );
                  }
                },
              ),


              const Text(
                'Qualité',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              FutureBuilder<List<Qualite>>(
                future: _databaseHelper.getQualites(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Qualite> qualites = snapshot.data ?? [];
                    return DropdownButtonFormField<String?>(
                      value: _selectedQualiteId != null && qualites.any((item) => item.id == _selectedQualiteId) ? _selectedQualiteId : null,
                      onChanged: (String? newValue) {
                        setState(() {
                          print('Qualite ID selected: $newValue');
                          _selectedQualiteId = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<String?>(
                          value: null,
                          child: Text(''),
                        ),
                        ...snapshot.data!.map<DropdownMenuItem<String?>>((Qualite item) {
                          return DropdownMenuItem<String?>(
                            value: item.id,
                            child: Text(item.libelle),
                          );
                        }).toList(),
                      ],
                    );
                  }
                },
              ),


              const Text(
                'Presentation',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              FutureBuilder<List<Presentation>>(
                future: _databaseHelper.getPresentations(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Presentation> presentations = snapshot.data ?? [];
                    return DropdownButtonFormField<String?>(
                      value: _selectedPresentationId != null && presentations.any((item) => item.id == _selectedPresentationId) ? _selectedPresentationId : null,
                      onChanged: (String? newValue) {
                        setState(() {
                          print('Presentation ID selected: $newValue');
                          _selectedPresentationId = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<String?>(
                          value: null,
                          child: Text(''),
                        ),
                        ...snapshot.data!.map<DropdownMenuItem<String?>>((Presentation item) {
                          return DropdownMenuItem<String?>(
                            value: item.id,
                            child: Text(item.libelle),
                          );
                        }).toList(),
                      ],
                    );
                  }
                },
              ),


              const Text(
                'Type Bac',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              FutureBuilder<List<TypeBac>>(
                future: _databaseHelper.getTypeBacs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<TypeBac> typeBacs = snapshot.data ?? [];
                    return DropdownButtonFormField<String?>(
                      value: _selectedTypeBacId != null && typeBacs.any((item) => item.id == _selectedTypeBacId) ? _selectedTypeBacId : null,
                      onChanged: (String? newValue) {
                        setState(() {
                          print('Type Bac ID selected: $newValue');
                          _selectedTypeBacId = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<String?>(
                          value: null,
                          child: Text(''),
                        ),
                        ...snapshot.data!.map<DropdownMenuItem<String?>>((TypeBac item) {
                          return DropdownMenuItem<String?>(
                            value: item.id,
                            child: Text('${item.id} / ${item.tare} Kg'),
                          );
                        }).toList(),
                      ],
                    );
                  }
                },
              ),






              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final bac = Bac(
                      id: widget.bacId,
                      idEspece: _selectedEspeceId ?? 0,
                      datePeche: _datePeche,
                      idTypeBac: _selectedTypeBacId ?? '',
                      idTaille: _selectedTailleId ?? 0,
                      idQualite: _selectedQualiteId ?? '',
                      idPresentation: _selectedPresentationId ?? '',
                    );
                    final id = await DatabaseHelper().updateBac(bac);
                    print('Bac modified with id: $id');
                    Navigator.pop(context, 'refresh');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Bac modifié avec succès')),
                    );
                  }
                },
                child: Text('Sauvegarder'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
