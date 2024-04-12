import 'package:flutter/material.dart';
import '../models/Database.dart';
import '../models/Bac.dart';

class BacController {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  Future<int> addBac(DateTime datePeche, String idTypeBac, int idEspece, int idTaille, String idQualite, String idPresentation) async {
    Bac newBac = Bac(id: 0, datePeche: datePeche, idTypeBac: idTypeBac, idEspece: idEspece, idTaille: idTaille, idQualite: idQualite, idPresentation: idPresentation);
    return await databaseHelper.insertBac(newBac);
  }

  Future<int> deleteBac(int id) async {
    return await databaseHelper.deleteBac(id);
  }

  Future<int> updateBac(int id, DateTime datePeche, String idTypeBac, int idEspece, int idTaille, String idQualite, String idPresentation) async {
    Bac updatedBac = Bac(id: id, datePeche: datePeche, idTypeBac: idTypeBac, idEspece: idEspece, idTaille: idTaille, idQualite: idQualite, idPresentation: idPresentation);
    return await databaseHelper.updateBac(updatedBac);
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
