class Espece {
  final int id;
  final String nom;
  final String nomScientifique;
  final String nomCourt;

  Espece({required this.id, required this.nom, required this.nomScientifique, required this.nomCourt});

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'nomScientifique': nomScientifique,
      'nomCourt': nomCourt,
    };
  }

  factory Espece.fromMap(Map<String, dynamic> map) {
    return Espece(
      id: map['id'],
      nom: map['nom'],
      nomScientifique: map['nomScientifique'],
      nomCourt: map['nomCourt'],
    );
  }
}