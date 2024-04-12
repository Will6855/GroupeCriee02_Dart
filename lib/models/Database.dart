import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Espece.dart';
import 'Bac.dart';
import 'Taille.dart';
import 'Qualite.dart';
import 'TypeBac.dart';
import 'Presentation.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bacs2.db');
    var especeDatabase = await openDatabase(path, version: 1, onCreate: _createDb, onUpgrade: _onUpgrade);
    return especeDatabase;
  }


  Future<void> insertDefaultEspeces(Database db) async {
    String especes = '''
      INSERT INTO `espece` (`id`, `nom`, `nomScientifique`, `nomCourt`) VALUES
(33760, 'Baudroie', 'Lophius Piscatorus', 'BAUDR'),
(33090, 'Bar de Chalut', 'Dicentrarchus Labrax', 'BARCH'),
(33091, 'Bar de Ligne', 'Dicentrarchus Labrax', 'BARLI'),
(32130, 'Lieu Jaune de Ligne', 'Pollachius pollachius', 'LJAUL'),
(42040, 'Araignée de mer casier', 'Maja squinado', 'ARAIS'),
(42041, 'Araignée de mer chalut', 'Maja squinado', 'ARAIL'),
(43010, 'Homard', 'Hammarus gammorus', 'HOMAR'),
(43030, 'Langouste rouge', 'Palinurus elephas', 'LANGR'),
(32140, 'Lieu Noir', 'Lophius Virens', 'LNOI'),
(31020, 'Turbot', 'Psetta maxima', 'TURBO'),
(33480, 'Dorade rose', 'Pagellus bogaraveo', 'DORAD'),
(38150, 'Raie douce', 'Raja Montagui', 'RAIE'),
(33020, 'Congre commun', 'Conger conger', 'CONGR'),
(32020, 'Merlu', 'Merluccius bilinearis', 'MERLU'),
(31030, 'Barbue', 'Scophthalmus rhombus', 'BARBU'),
(31150, 'Plie ou carrelet', 'Pleuronectes Platessa', 'PLIE'),
(32050, 'Cabillaud', 'Gadus Morhua Morhue', 'CABIL'),
(32230, 'Lingue franche', 'Molva Molva', 'LINGU'),
(33080, 'Saint Pierre', 'Zeus Faber', 'STPIE'),
(33110, 'Mérou ou cernier', 'Polyprion Americanus', 'CERNI'),
(33120, 'Mérou noir', 'Epinephelus Guaza', 'MEROU'),
(33410, 'Rouget Barbet', 'Mullus SPP', 'ROUGT'),
(33450, 'Dorade royale chalut', 'Sparus Aurata', 'DORAC'),
(33451, 'Dorade royale ligne', 'Sparus Aurata', 'DORAL'),
(33490, 'Pageot Acarne', 'Pagellus Acarne', 'PAGEO'),
(33500, 'Pageot Commun', 'Pagellus Arythrinus', 'PAGEC'),
(33580, 'Vieille', 'LabrusBergylta', 'VIEIL'),
(33730, 'Grondin gris', 'Eutrigla Gurnadus', 'GRONG'),
(33740, 'Grondin rouge', 'Aspitrigla Cuculus', 'GRONR'),
(33761, 'Baudroie Maigre', 'Lophius Piscicatorius', 'BAUDM'),
(33790, 'Grondin Camard', 'Trigloporus Lastoviza', 'GRONC'),
(33800, 'Grondin Perlon', 'Trigla Lucerna', 'GRONP'),
(34150, 'Mulet', 'Mugil SPP', 'MULET'),
(35040, 'Sardine atlantique', 'Sardina Pilchardus', 'SARDI'),
(37050, 'Maquereau', 'Scomber Scombrus', 'MAQUE'),
(38160, 'Raie Pastenague commune', 'Dasyatis Pastinaca', 'RAIEP'),
(42020, 'Crabe tourteau de casier', 'Cancer Pagurus', 'CRABS'),
(42021, 'Crabe tourteau de chalut', 'Cancer Pagurus', 'CRABL'),
(44010, 'Langoustine', 'Nephrops norvegicus', 'LANGT'),
(57010, 'Seiche', 'Sepia SPP', 'SEICH'),
(57020, 'Calmar', 'Loligo SPP', 'CALAM'),
(57050, 'Poulpe', 'Octopus SPP', 'POULP');
    ''';

    await db.execute(especes);
  }

  Future<void> insertDefaultTailles(Database db) async {
    String tailles = '''
    INSERT INTO `taille` (`id`, `specification`) VALUES
(10, 'TAILLE de 10'),
(15, 'TAILLE de 15'),
(20, 'TAILLE de 20'),
(25, 'TAILLE de 25'),
(30, 'TAILLE de 30'),
(35, 'TAILLE de 35'),
(40, 'TAILLE de 40'),
(45, 'TAILLE de 45'),
(50, 'TAILLE de 50'),
(55, 'TAILLE de 55'),
(60, 'TAILLE de 60'),
(65, 'TAILLE de 65'),
(70, 'TAILLE de 70'),
(75, 'TAILLE de 75'),
(80, 'TAILLE de 80'),
(85, 'TAILLE de 85'),
(90, 'TAILLE de 90'),
(95, 'TAILLE de 95');
    ''';
    await db.execute(tailles);
}
  Future<void> insertDefaultQualites(Database db) async {
    String qualites = '''
INSERT INTO `qualite` (`id`, `libelle`) VALUES
('A', 'glacé'),
('B', 'déclassé'),
('E', 'extra');
    ''';
    await db.execute(qualites);
  }

  Future<void> insertDefaultPresentations(Database db) async {
    String presentations = '''
INSERT INTO `presentation` (`id`, `libelle`) VALUES
('ET', 'Etété'),
('ENT', 'Entier'),
('VID', 'Vidé');
    ''';
    await db.execute(presentations);
  }

  Future<void> insertDefaultTypeBacs(Database db) async {
    String typeBacs = '''
INSERT INTO `typebac` (`id`, `tare`) VALUES
('B', 2.5),
('F', 4);
    ''';
    await db.execute(typeBacs);
  }




  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE bac( id INTEGER PRIMARY KEY AUTOINCREMENT, datePeche DATETIME, idBateau INTEGER, idTypeBac INTEGER, idEspece INTEGER, idTaille INTEGER, idQualite TEXT, idPresentation INTEGER );"
    );
    await db.execute(
        "CREATE TABLE espece(id INTEGER PRIMARY KEY, nom TEXT, nomScientifique TEXT, nomCourt TEXT);"
    );
    await db.execute(
        "CREATE TABLE taille(id INTEGER PRIMARY KEY, specification TEXT);"
    );
    await db.execute(
        "CREATE TABLE qualite(id TEXT PRIMARY KEY, libelle TEXT);"
    );
    await db.execute(
        "CREATE TABLE presentation(id TEXT PRIMARY KEY, libelle TEXT);"
    );
    await db.execute(
        "CREATE TABLE typebac(id TEXT PRIMARY KEY, tare TEXT);"
    );
    await insertDefaultEspeces(db);
    await insertDefaultTailles(db);
    await insertDefaultQualites(db);
    await insertDefaultPresentations(db);
    await insertDefaultTypeBacs(db);
  }


  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute(
        "CREATE TABLE bac( id INTEGER PRIMARY KEY AUTOINCREMENT, datePeche DATETIME, idBateau INTEGER, idTypeBac INTEGER, idEspece INTEGER, idTaille INTEGER, idQualite INTEGER, idPresentation INTEGER );"
    );
    await db.execute(
        "CREATE TABLE espece(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, nomScientifique TEXT, nomCourt TEXT);"
    );
  }

  Future<void> closeDatabase() async {
    await _database?.close();
  }





  Future<List<Bac>> getBacs() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('bac');
    List<Bac> bacs = [];
    for (var map in maps) {
      bacs.add(Bac(
        id: map['id'],
        datePeche: DateTime.parse(map['datePeche']),
        idTypeBac: map['idTypeBac'],
        idEspece: map['idEspece'],
        idTaille: map['idTaille'],
        idQualite: map['idQualite'],
        idPresentation: map['idPresentation'],
      ));
    }
    return bacs;
  }

  Future<Bac?> getBacById(int id) async {
    final Database db = await database; // Ensure 'database' is your database instance
    final List<Map<String, dynamic>> maps = await db.query('bac',
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Bac.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteBac(int id) async {
    Database db = await database;
    return await db.delete('bac', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateBac(Bac bac) async {
    Database db = await database;
    return await db.update('bac', bac.toMap(),
        where: 'id = ?', whereArgs: [bac.id]);
  }

  Future<int> insertBac(Bac bac) async {
    Database db = await database;
    return await db.insert('bac', bac.toMap());
  }




  Future<List<Espece>> getEspeces() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('espece');
    List<Espece> especes = [];
    for (var map in maps) {
      especes.add(Espece(
        id: map['id'],
        nom: map['nom'],
        nomScientifique: map['nomScientifique'],
        nomCourt: map['nomCourt'],
      ));
    }
    return especes;
  }

  Future<Espece?> getEspeceById(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('espece',
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Espece.fromMap(maps.first);
    }
    return null;
  }


  Future<List<Taille>> getTailles() async {
    Database db = await database; // Ensure 'database' is your database instance
    List<Map<String, dynamic>> maps = await db.query('taille');
    List<Taille> tailles = [];
    for (var map in maps) {
      tailles.add(Taille.fromMap(map));
    }
    return tailles;
  }

  Future<Taille?> getTailleById(int id) async {
    final Database db = await database; // Ensure 'database' is your database instance
    final List<Map<String, dynamic>> maps = await db.query('taille',
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Taille.fromMap(maps.first);
    }
    return null;
  }


  Future<List<Qualite>> getQualites() async {
    Database db = await database; // Ensure 'database' is your database instance
    List<Map<String, dynamic>> maps = await db.query('qualite');
    List<Qualite> qualites = [];
    for (var map in maps) {
      qualites.add(Qualite.fromMap(map));
    }
    return qualites;
  }

  Future<Qualite?> getQualiteById(String id) async {
    final Database db = await database; // Ensure 'database' is your database instance
    final List<Map<String, dynamic>> maps = await db.query('qualite',
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Qualite.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Presentation>> getPresentations() async {
    Database db = await database; // Ensure 'database' is your database instance
    List<Map<String, dynamic>> maps = await db.query('presentation');
    List<Presentation> presentations = [];
    for (var map in maps) {
      presentations.add(Presentation.fromMap(map));
    }
    return presentations;
  }

  Future<Presentation?> getPresentationById(String id) async {
    final Database db = await database; // Ensure 'database' is your database instance
    final List<Map<String, dynamic>> maps = await db.query('presentation',
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Presentation.fromMap(maps.first);
    }
    return null;
  }

  Future<List<TypeBac>> getTypeBacs() async {
    Database db = await database; // Ensure 'database' is your database instance
    List<Map<String, dynamic>> maps = await db.query('typebac');
    List<TypeBac> typebacs = [];
    for (var map in maps) {
      typebacs.add(TypeBac.fromMap(map));
    }
    return typebacs;
  }

  Future<TypeBac?> getTypeBacById(String id) async {
    final Database db = await database; // Ensure 'database' is your database instance
    final List<Map<String, dynamic>> maps = await db.query('typebac',
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return TypeBac.fromMap(maps.first);
    }
    return null;
  }

}
