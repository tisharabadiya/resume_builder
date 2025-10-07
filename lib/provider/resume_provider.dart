import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/models/education.dart';
import 'package:resume_builder/models/experience.dart';
import 'package:resume_builder/models/objective.dart';
import 'package:resume_builder/models/personal_detail.dart';
import 'package:resume_builder/models/resume.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResumeProvider with ChangeNotifier {
  List<Resume> _resumes = [];
  List<Resume> get resumes => _resumes;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  PersonalDetails? _personalDetails;
  List<Education> _educations = [];
  List<Experience> _experiences = [];
  List<String> _skills = [];
  Objective? _objective;
  bool _hasDetails = false;

  PersonalDetails? get personalDetails => _personalDetails;
  List<Education> get educations => _educations;
  List<Experience> get experiences => _experiences;
  List<String> get skills => _skills;
  Objective? get objective => _objective;
  bool get hasDetails => _hasDetails;

  int? editingResumeIndex;

  List<String> _sectionOrder = [
    'Objective',
    'Experience',
    'Personal Details',
    'Education',
    'Skills',
  ];

  final List<String> _defaultSectionOrder = const [
    'Objective',
    'Experience',
    'Personal Details',
    'Education',
    'Skills',
  ];

  List<String> get defaultSections => List<String>.from(_defaultSectionOrder);

  List<String> get sectionOrder => _sectionOrder;

  ResumeProvider() {
    _loadPersonalDetails();
    _loadEducations();
    _loadExperiences();
    _loadSkills();
    _loadObjective();
    _loadSectionOrder();
    _loadResumes();
  }

  Future<void> _loadPersonalDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    final address = prefs.getString('address');
    final email = prefs.getString('email');
    final phone = prefs.getString('phone');

    if (name != null && email != null && phone != null) {
      _personalDetails = PersonalDetails(
        name: name,
        address: address ?? '',
        email: email,
        phone: phone,
      );
      _hasDetails = true;
    } else {
      _hasDetails = false;
    }
    notifyListeners();
  }

  Future<void> savePersonalDetails(PersonalDetails details) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', details.name);
    await prefs.setString('address', details.address);
    await prefs.setString('email', details.email);
    await prefs.setString('phone', details.phone);

    _personalDetails = details;
    _hasDetails = true;
    notifyListeners();
  }

  Future<void> _loadEducations() async {
    final prefs = await SharedPreferences.getInstance();
    final educationStrings = prefs.getStringList('educations') ?? [];
    _educations =
        educationStrings
            .map(
              (educationString) => Education.fromMap(
                Map<String, dynamic>.from(json.decode(educationString)),
              ),
            )
            .toList();
    notifyListeners();
  }

  Future<void> saveEducations(List<Education> educations) async {
    final prefs = await SharedPreferences.getInstance();
    final educationStrings =
        educations.map((education) => json.encode(education.toMap())).toList();
    await prefs.setStringList('educations', educationStrings);

    _educations = educations;
    _hasDetails = true;
    notifyListeners();
  }

  Future<void> addEducation(Education education) async {
    final educations = List<Education>.from(_educations)..add(education);
    await saveEducations(educations);
  }

  Future<void> updateEducation(int index, Education education) async {
    _educations[index] = education;
    await saveEducations(_educations);
  }

  Future<void> _loadExperiences() async {
    final prefs = await SharedPreferences.getInstance();
    final experienceStrings = prefs.getStringList('experiences') ?? [];
    _experiences =
        experienceStrings
            .map(
              (experienceString) => Experience.fromMap(
                Map<String, dynamic>.from(json.decode(experienceString)),
              ),
            )
            .toList();
    notifyListeners();
  }

  Future<void> saveExperiences(List<Experience> experiences) async {
    final prefs = await SharedPreferences.getInstance();
    final experienceStrings =
        experiences
            .map((experience) => json.encode(experience.toMap()))
            .toList();
    await prefs.setStringList('experiences', experienceStrings);

    _experiences = experiences;
    _hasDetails = true;
    notifyListeners();
  }

  Future<void> addExperience(Experience experience) async {
    final experiences = List<Experience>.from(_experiences)..add(experience);
    await saveExperiences(experiences);
  }

  Future<void> updateExperience(int index, Experience experience) async {
    _experiences[index] = experience;
    await saveExperiences(_experiences);
  }

  Future<void> _loadSkills() async {
    final prefs = await SharedPreferences.getInstance();
    _skills = prefs.getStringList('skills') ?? [];
    notifyListeners();
  }

  Future<void> saveSkills(List<String> skills) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('skills', skills);

    _skills = skills;
    _hasDetails = true;
    notifyListeners();
  }

  Future<void> addSkill(String skill) async {
    final skills = List<String>.from(_skills)..add(skill);
    await saveSkills(skills);
  }

  Future<void> removeSkill(String skill) async {
    final skills = _skills.where((s) => s != skill).toList();
    await saveSkills(skills);
  }

  Future<void> _loadObjective() async {
    final prefs = await SharedPreferences.getInstance();
    final objectiveString = prefs.getString('objective');
    if (objectiveString != null) {
      _objective = Objective.fromMap(
        Map<String, dynamic>.from(json.decode(objectiveString)),
      );
    }
    notifyListeners();
  }

  Future<void> saveObjective(Objective objective) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('objective', json.encode(objective.toMap()));

    _objective = objective;
    _hasDetails = true;
    notifyListeners();
  }

  Future<void> _loadSectionOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getStringList('sectionOrder');
    if (savedOrder != null) {
      final sectionOrder =
          savedOrder.where((s) => _defaultSectionOrder.contains(s)).toList();

      _sectionOrder =
          sectionOrder.isNotEmpty
              ? sectionOrder
              : List<String>.from(_defaultSectionOrder);
    }
    notifyListeners();
  }

  Future<void> saveSectionOrder(List<String> order) async {
    final prefs = await SharedPreferences.getInstance();
    //only allowed default sections
    final filtered =
        order.where((s) => _defaultSectionOrder.contains(s)).toList();
    await prefs.setStringList('sectionOrder', filtered);
    _sectionOrder = filtered;
    notifyListeners();
  }

  Future<void> _loadResumes() async {
    final prefs = await SharedPreferences.getInstance();
    final resumeStrings = prefs.getStringList('resumes') ?? [];
    _resumes =
        resumeStrings
            .map(
              (resumeString) => Resume.fromMap(
                Map<String, dynamic>.from(json.decode(resumeString)),
              ),
            )
            .toList();
    notifyListeners();
  }

  Future<void> saveResumes() async {
    final prefs = await SharedPreferences.getInstance();
    final resumeStrings =
        _resumes.map((resume) => json.encode(resume.toMap())).toList();
    await prefs.setStringList('resumes', resumeStrings);
    notifyListeners();
  }

  Future<void> deleteResume(int index) async {
    _resumes.removeAt(index);
    await saveResumes();
  }

  Future<void> loadResumeForEditing(int index) async {
    editingResumeIndex = index;
    _isEditing = true;
    final resume = _resumes[index];
    _personalDetails = resume.personalDetails;
    _educations = resume.educations;
    _experiences = resume.experiences;
    _skills = resume.skills;
    _objective = resume.objective;
    _hasDetails = true;
    notifyListeners();
  }

  void createNewResume() {
    editingResumeIndex = null;
    _isEditing = false;
    _personalDetails = null;
    _educations = [];
    _experiences = [];
    _skills = [];
    _objective = null;
    _hasDetails = false;
    notifyListeners();
  }

  // Save current resume
  Future<void> saveCurrentResume() async {
    final resume = Resume(
      personalDetails: _personalDetails!,
      educations: _educations,
      experiences: _experiences,
      skills: _skills,
      objective: _objective,
    );
    if (editingResumeIndex != null) {
      _resumes[editingResumeIndex!] = resume;
    } else {
      _resumes.add(resume);
    }

    await saveResumes();
    editingResumeIndex = null;
  }
}
