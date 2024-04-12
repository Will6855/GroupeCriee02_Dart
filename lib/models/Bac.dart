class Bac {
  final int? id;
  final DateTime datePeche;
  final String? idTypeBac;
  final int? idEspece;
  final int? idTaille;
  final String? idQualite;
  final String? idPresentation;

  Bac({this.id, required this.datePeche, this.idTypeBac, this.idEspece, this.idTaille, this.idQualite, this.idPresentation});

  Map<String, dynamic> toMap() {
    return {
      'datePeche': datePeche.toIso8601String(),
      'idTypeBac': idTypeBac,
      'idEspece': idEspece,
      'idTaille': idTaille,
      'idQualite': idQualite,
      'idPresentation': idPresentation,
    };
  }

  factory Bac.fromMap(Map<String, dynamic> map) {
    return Bac(
      id: map['id'],
      datePeche: DateTime.parse(map['datePeche']),
      idTypeBac: map['idTypeBac'],
      idEspece: map['idEspece'],
      idTaille: map['idTaille'],
      idQualite: map['idQualite'],
      idPresentation: map['idPresentation'],
    );
  }
}