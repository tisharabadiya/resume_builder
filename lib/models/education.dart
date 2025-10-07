class Education {
  final String degree;
  final String schoolOrUniversity;
  final String grade;
  final String year;

  Education({
    required this.degree,
    required this.schoolOrUniversity,
    required this.grade,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'degree': degree,
      'schoolOrUniversity': schoolOrUniversity,
      'grade': grade,
      'year': year,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      degree: map['degree'] ?? '',
      schoolOrUniversity: map['schoolOrUniversity'] ?? '',
      grade: map['grade'] ?? '',
      year: map['year'] ?? '',
    );
  }
}
