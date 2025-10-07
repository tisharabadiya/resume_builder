import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/models/objective.dart';
import 'package:resume_builder/provider/resume_provider.dart';

class ObjectiveScreen extends StatefulWidget {
  const ObjectiveScreen({super.key});

  @override
  State<ObjectiveScreen> createState() => _ObjectiveScreenState();
}

class _ObjectiveScreenState extends State<ObjectiveScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _objectiveController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resumeProvider = Provider.of<ResumeProvider>(
        context,
        listen: false,
      );
      if (resumeProvider.isEditing && resumeProvider.objective != null) {
        _objectiveController.text = resumeProvider.objective!.description;
      }
    });
  }

  @override
  void dispose() {
    _objectiveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Objective')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Objective Field
              TextFormField(
                controller: _objectiveController,
                decoration: const InputDecoration(
                  labelText: 'Objective',
                  hintText:
                      'e.g., To secure a challenging position in a reputable organization...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your objective';
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
                    final objective = Objective(
                      description: _objectiveController.text,
                    );
                    await resumeProvider.saveObjective(objective);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Objective saved successfully!'),
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
