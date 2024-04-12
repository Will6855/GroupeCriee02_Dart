class Qualite {
  final String id;
  final String libelle;

  Qualite({required this.id, required this.libelle});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelle': libelle,
    };
  }

  // Factory constructor to create an instance of Qualite from a Map
  factory Qualite.fromMap(Map<String, dynamic> map) {
    return Qualite(
      id: map['id'],
      libelle: map['libelle'],
    );
  }
}
