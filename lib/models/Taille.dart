class Taille {
  final int id;
  final String specification;

  Taille({required this.id, required this.specification});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'specification': specification,
    };
  }

  // Factory constructor to create an instance of Taille from a Map
  factory Taille.fromMap(Map<String, dynamic> map) {
    return Taille(
      id: map['id'],
      specification: map['specification'],
    );
  }
}
