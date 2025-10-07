class Experience {
  final String companyName;
  final String jobTitle;
  final String startDate;
  final String endDate;
  final String details;

  Experience({
    required this.companyName,
    required this.jobTitle,
    required this.startDate,
    required this.endDate,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'jobTitle': jobTitle,
      'startDate': startDate,
      'endDate': endDate,
      'details': details,
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      companyName: map['companyName'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      details: map['details'] ?? '',
    );
  }
}
