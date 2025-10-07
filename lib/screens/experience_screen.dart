import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/models/experience.dart';
import 'package:resume_builder/provider/resume_provider.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _jobTitleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _detailsController.dispose();
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
      if (resumeProvider.isEditing && resumeProvider.experiences.isNotEmpty) {
        // Load the first experience for editing (or implement a way to select which experience to edit)
        final experience = resumeProvider.experiences.first;
        _companyNameController.text = experience.companyName;
        _jobTitleController.text = experience.jobTitle;
        _startDateController.text = experience.startDate;
        _endDateController.text = experience.endDate;
        _detailsController.text = experience.details;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Experience')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Company Name Field
              TextFormField(
                controller: _companyNameController,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  hintText: 'e.g., Tech Corp',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the company name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Job Title Field
              TextFormField(
                controller: _jobTitleController,
                decoration: const InputDecoration(
                  labelText: 'Job Title',
                  hintText: 'e.g., Software Engineer',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your job title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Start Date Field
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(
                  labelText: 'Start Date',
                  hintText: 'e.g., Jan 2020',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // End Date Field
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  hintText: 'e.g., Present or Dec 2022',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Details Field
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  labelText: 'Details',
                  hintText: 'e.g., Developed mobile applications using Flutter',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
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
                    final experience = Experience(
                      companyName: _companyNameController.text,
                      jobTitle: _jobTitleController.text,
                      startDate: _startDateController.text,
                      endDate: _endDateController.text,
                      details: _detailsController.text,
                    );
                    if (resumeProvider.isEditing) {
                      await resumeProvider.updateExperience(0, experience);
                    } else {
                      await resumeProvider.addExperience(experience);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Experience details saved successfully!'),
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
