class Presentation {
  final String id;
  final String libelle;

  Presentation({required this.id, required this.libelle});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelle': libelle,
    };
  }

  // Factory constructor to create an instance of Presentation from a Map
  factory Presentation.fromMap(Map<String, dynamic> map) {
    return Presentation(
      id: map['id'],
      libelle: map['libelle'],
    );
  }
}
