import 'package:resume_builder/models/education.dart';
import 'package:resume_builder/models/experience.dart';
import 'package:resume_builder/models/objective.dart';
import 'package:resume_builder/models/personal_detail.dart';

class Resume {
  final PersonalDetails personalDetails;
  final List<Education> educations;
  final List<Experience> experiences;
  final List<String> skills;
  final Objective? objective;

  Resume({
    required this.personalDetails,
    required this.educations,
    required this.experiences,
    required this.skills,
    this.objective,
  });

  Map<String, dynamic> toMap() {
    return {
      'personalDetails': personalDetails.toMap(),
      'educations': educations.map((education) => education.toMap()).toList(),
      'experiences':
          experiences.map((experience) => experience.toMap()).toList(),
      'skills': skills,
      'objective': objective?.toMap(),
    };
  }

  factory Resume.fromMap(Map<String, dynamic> map) {
    return Resume(
      personalDetails: PersonalDetails.fromMap(map['personalDetails']),
      educations:
          (map['educations'] as List<dynamic>)
              .map((education) => Education.fromMap(education))
              .toList(),
      experiences:
          (map['experiences'] as List<dynamic>)
              .map((experience) => Experience.fromMap(experience))
              .toList(),
      skills: List<String>.from(map['skills']),
      objective:
          map['objective'] != null ? Objective.fromMap(map['objective']) : null,
    );
  }
}
