class Objective {
  final String description;

  Objective({required this.description});

  Map<String, dynamic> toMap() {
    return {'description': description};
  }

  factory Objective.fromMap(Map<String, dynamic> map) {
    return Objective(description: map['description'] ?? '');
  }
}
