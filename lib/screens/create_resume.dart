import 'package:flutter/material.dart';
import 'package:resume_builder/screens/personal_details.dart';

class CreateResume extends StatelessWidget {
  const CreateResume({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Details Section
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Personal Details'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalDetailsScreen(),
                      ),
                    );
                  },
                ),
              ),
              // Education Section
              Card(
                child: ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Education'),

                  onTap: () {},
                ),
              ),
              // Experience Section
              Card(
                child: ListTile(
                  leading: const Icon(Icons.work),
                  title: const Text('Experience'),
                  onTap: () {},
                ),
              ),
              // Skills Section
              Card(
                child: ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('Skills'),
                  onTap: () {},
                ),
              ),
              // Objective Section
              Card(
                child: ListTile(
                  leading: const Icon(Icons.flag),
                  title: const Text('Objective'),
                  onTap: () {},
                ),
              ),

              // Manage Sections
              const SizedBox(height: 20),
              const Text(
                'Manage Sections',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.swap_vert),
                  title: const Text('Rearrange / Edit Headings'),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.remove_red_eye),
          label: const Text('View CV'),
        ),
      ),
    );
  }
}
