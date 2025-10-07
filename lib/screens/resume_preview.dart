import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/provider/resume_provider.dart';

class ResumePreview extends StatelessWidget {
  final bool hasDetails;

  const ResumePreview({super.key, required this.hasDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your CV')),
      body: hasDetails ? const _FilledCV() : const _EmptyCV(),
    );
  }
}

class _FilledCV extends StatelessWidget {
  const _FilledCV();

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final personalDetails = resumeProvider.personalDetails;
    final educations = resumeProvider.educations;
    final experiences = resumeProvider.experiences;
    final skills = resumeProvider.skills;
    final objective = resumeProvider.objective;
    final List<String> sectionOrder = resumeProvider.sectionOrder;
    final allowedSections = resumeProvider.defaultSections;

    final displayOrder =
        sectionOrder.where((s) => allowedSections.contains(s)).toList();

    // Map section names to widgets
    final sectionWidgets = <String, Widget>{
      'Objective': Card(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(objective?.description ?? 'No objective added yet.'),
        ),
      ),
      'Experience': Column(
        children:
            experiences
                .map(
                  (experience) => Card(
                    child: ListTile(
                      title: Text(experience.jobTitle),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(experience.companyName),
                          Text(
                            '${experience.startDate} - ${experience.endDate}',
                          ),
                          Text(experience.details),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
      'Personal Details': Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${personalDetails?.name ?? "No Name"}'),
              Text('Email: ${personalDetails?.email ?? "No Email"}'),
              Text('Phone: ${personalDetails?.phone ?? "No Phone"}'),
              Text('Address: ${personalDetails?.address ?? "No Address"}'),
            ],
          ),
        ),
      ),
      'Education': Column(
        children:
            educations
                .map(
                  (education) => Card(
                    child: ListTile(
                      title: Text(education.degree),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(education.schoolOrUniversity),
                          Text('Grade: ${education.grade}'),
                          Text('Year: ${education.year}'),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
      'Skills': Wrap(
        spacing: 8.0,
        children: skills.map((skill) => Chip(label: Text(skill))).toList(),
      ),
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Personal Details Header
          // Center(
          //   child: Text(
          //     personalDetails?.name ?? 'No Name',
          //     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(height: 20),

          // Display sections in the order defined by the user
          ...displayOrder.map((section) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayOrder.singleWhere((s) => s == section),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                sectionWidgets[section] ?? const SizedBox.shrink(),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _EmptyCV extends StatelessWidget {
  const _EmptyCV();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Please fill in your details to generate your CV.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
