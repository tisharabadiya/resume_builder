import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/models/education.dart';
import 'package:resume_builder/models/personal_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResumeProvider with ChangeNotifier {
  bool _isEditing = false;
  bool get isEditing => _isEditing;

  PersonalDetails? _personalDetails;
  List<Education> _educations = [];
  bool _hasDetails = false;

  PersonalDetails? get personalDetails => _personalDetails;
  List<Education> get educations => _educations;
  bool get hasDetails => _hasDetails;

  ResumeProvider() {
    _loadPersonalDetails();
    _loadEducations();
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
}
