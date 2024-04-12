import 'package:flutter/material.dart';

import 'showBac.dart';
import '../models/Database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Criée de Poulgoazec',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShowBac(),
    );
  }
}