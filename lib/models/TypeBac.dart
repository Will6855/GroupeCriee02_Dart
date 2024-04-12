class TypeBac {
  final String id;
  final String tare;

  TypeBac({required this.id, required this.tare});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tare': tare,
    };
  }

  // Factory constructor to create an instance of TypeBac from a Map
  factory TypeBac.fromMap(Map<String, dynamic> map) {
    return TypeBac(
      id: map['id'],
      tare: map['tare'],
    );
  }
}
