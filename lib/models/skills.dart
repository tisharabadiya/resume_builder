class Skills {
  final List<String> skills;

  Skills({required this.skills});

  List<String> toList() {
    return skills;
  }

  factory Skills.fromList(List<String> list) {
    return Skills(skills: list);
  }
}
