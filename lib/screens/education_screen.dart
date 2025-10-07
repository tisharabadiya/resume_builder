import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/models/education.dart';
import 'package:resume_builder/provider/resume_provider.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _schoolOrUniversityController =
      TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void dispose() {
    _degreeController.dispose();
    _schoolOrUniversityController.dispose();
    _gradeController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resumeProvider = Provider.of<ResumeProvider>(
        context,
        listen: false,
      );
      if (resumeProvider.isEditing && resumeProvider.educations.isNotEmpty) {
        final education = resumeProvider.educations.first;
        _degreeController.text = education.degree;
        _schoolOrUniversityController.text = education.schoolOrUniversity;
        _gradeController.text = education.grade;
        _yearController.text = education.year;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Education'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Degree Field
              TextFormField(
                controller: _degreeController,
                decoration: const InputDecoration(
                  labelText: 'Degree',
                  hintText: 'e.g., Bachelor of Science',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your degree';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // School/University Field
              TextFormField(
                controller: _schoolOrUniversityController,
                decoration: const InputDecoration(
                  labelText: 'School or University',
                  hintText: 'e.g., University of Example',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your school or university';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Grade Field
              TextFormField(
                controller: _gradeController,
                decoration: const InputDecoration(
                  labelText: 'Grade',
                  hintText: 'e.g., A',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Year Field
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  hintText: 'e.g., 2018-2022',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Save Button
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final resumeProvider = Provider.of<ResumeProvider>(
                      context,
                      listen: false,
                    );
                    final education = Education(
                      degree: _degreeController.text,
                      schoolOrUniversity: _schoolOrUniversityController.text,
                      grade: _gradeController.text,
                      year: _yearController.text,
                    );
                    if (resumeProvider.isEditing) {
                      await resumeProvider.updateEducation(0, education);
                    } else {
                      await resumeProvider.addEducation(education);
                    }
                    await resumeProvider.saveCurrentResume();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Education details saved successfully!'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.check),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
