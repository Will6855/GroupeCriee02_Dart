import 'package:flutter/material.dart';

import '../models/Bac.dart';
import '../models/Espece.dart';
import '../models/Taille.dart';
import '../models/Qualite.dart';
import '../models/Presentation.dart';
import '../models/TypeBac.dart';

import '../models/Database.dart';

class AddBac extends StatefulWidget {
  @override
  _AddBacState createState() => _AddBacState();
}

class _AddBacState extends State<AddBac> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  int? _selectedEspeceId = null;
  int? _selectedTailleId = null;
  String? _selectedQualiteId = null;
  String? _selectedPresentationId = null;
  String? _selectedTypeBacId = null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ajouter Bac'),
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
                    return DropdownButtonFormField<int?>(
                      value: _selectedEspeceId,
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
                    return DropdownButtonFormField<int?>(
                      value: _selectedTailleId,
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
                    return DropdownButtonFormField<String?>(
                      value: _selectedQualiteId,
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
                    return DropdownButtonFormField<String?>(
                      value: _selectedPresentationId,
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
                    return DropdownButtonFormField<String?>(
                      value: _selectedTypeBacId,
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
                      idEspece: _selectedEspeceId, datePeche: DateTime.now(), idTypeBac: _selectedTypeBacId, idTaille: _selectedTailleId, idQualite: _selectedQualiteId, idPresentation: _selectedPresentationId,
                    );
                    final id = await DatabaseHelper().insertBac(bac);
                    print('Bac saved with id: $id');
                    Navigator.pop(context, 'refresh');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Bac ajouté avec succès')),
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
