import 'package:flutter/material.dart';
import 'package:resume_builder/screens/create_resume.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intelligent CV')),
      body: Center(child: Text('List of Resumes will appear here')),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateResume()),
          );
        },
        tooltip: 'Create Resume',
        child: const Icon(Icons.add),
      ),
    );
  }
}
