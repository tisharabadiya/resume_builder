import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/provider/resume_provider.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final TextEditingController _skillController = TextEditingController();

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final skills = resumeProvider.skills;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Skills')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Skill Input Field
            TextField(
              controller: _skillController,
              decoration: const InputDecoration(
                labelText: 'Add a Skill',
                hintText: 'e.g., Flutter',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  await resumeProvider.addSkill(value);
                  _skillController.clear();
                }
              },
            ),
            const SizedBox(height: 16),

            // Add Button
            ElevatedButton.icon(
              onPressed: () async {
                if (_skillController.text.isNotEmpty) {
                  await resumeProvider.addSkill(_skillController.text);
                  _skillController.clear();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Skill'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Skills List
            const Text(
              'Your Skills:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Display Skills as Chips
            Wrap(
              spacing: 8.0,
              children:
                  skills
                      .map(
                        (skill) => Chip(
                          label: Text(skill),
                          onDeleted: () async {
                            await resumeProvider.removeSkill(skill);
                          },
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
