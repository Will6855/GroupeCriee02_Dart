import 'package:flutter/material.dart';
import '../models/Database.dart';
import '../models/Bac.dart';
import '../models/Espece.dart';
import '../models/Taille.dart';
import '../models/Qualite.dart';
import '../models/Presentation.dart';
import '../models/TypeBac.dart';

//import '../views/addBac.dart';
//import '../views/editBac.dart';

import 'package:intl/intl.dart'; // Format Date


class ShowBac extends StatefulWidget {
  @override
  _ShowBacState createState() => _ShowBacState();
}

class _ShowBacState extends State<ShowBac> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gestion Bacs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () { // Ne fonctionne pas
              },
              child: Text('Synchroniser'),
            ),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Ajouter un bac'),
            ),
            FutureBuilder<List<Bac>>(
              future: _databaseHelper.getBacs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Text('\n\nTotal de bac: ${snapshot.data!.length}');
                }
              },
            ),
            Expanded(
              child: FutureBuilder<List<Bac>>(
                future: _databaseHelper.getBacs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {

                    for (Bac bac in snapshot.data!) {
                      print('ID: ${bac.id}');
                      print('ESPECE: ${bac.idEspece}');
                      print('TAILLE: ${bac.idTaille}');
                      print('QUALITE: ${bac.idQualite}');
                      print('PRESENTATION: ${bac.idPresentation}');
                      print('-----------------------------------');
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final bac = snapshot.data![index];
                        return Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder<Espece?>(
                                      future: bac.idEspece != null ? _databaseHelper.getEspeceById(bac.idEspece!) : null,
                                      builder: (BuildContext context, AsyncSnapshot<Espece?> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          return Text('ESPECE: ${snapshot.data?.nom ?? 'Not found'}');
                                        } else {
                                          return Text('ESPECE: Non-renseigné');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder<Taille?>(
                                      future: bac.idTaille != null ? _databaseHelper.getTailleById(bac.idTaille!) : null,
                                      builder: (BuildContext context, AsyncSnapshot<Taille?> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          return Text('TAILLE: ${snapshot.data?.specification ?? 'Not found'}');
                                        } else {
                                          return Text('TAILLE: Non-renseigné');
                                        }
                                      },
                                    ),
                                    FutureBuilder<Qualite?>(
                                      future: bac.idQualite != null ? _databaseHelper.getQualiteById(bac.idQualite!) : null,
                                      builder: (BuildContext context, AsyncSnapshot<Qualite?> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          return Text('QUALITE: ${snapshot.data?.libelle ?? 'Not found'}');
                                        } else {
                                          return Text('QUALITE: Non-renseigné');
                                        }
                                      },
                                    ),
                                    FutureBuilder<Presentation?>(
                                      future: bac.idPresentation != null ? _databaseHelper.getPresentationById(bac.idPresentation!) : null,
                                      builder: (BuildContext context, AsyncSnapshot<Presentation?> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          return Text('PRESENTATION: ${snapshot.data?.libelle ?? 'Not found'}');
                                        } else {
                                          return Text('PRESENTATION: Non-renseigné');
                                        }
                                      },
                                    ),

                                    Text('DATE: ${DateFormat('dd/MM/yyyy').format(bac.datePeche)}'),

                                    FutureBuilder<TypeBac?>(
                                      future: bac.idTypeBac != null ? _databaseHelper.getTypeBacById(bac.idTypeBac!) : null,
                                      builder: (BuildContext context, AsyncSnapshot<TypeBac?> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          return Text('TYPE BAC: ${snapshot.data?.id ?? 'Not found'} / ${snapshot.data?.tare ?? 'Not found'} Kg');
                                        } else {
                                          return Text('TYPE BAC: Non-renseigné');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
