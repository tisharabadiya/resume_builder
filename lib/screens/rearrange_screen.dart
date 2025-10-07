import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/provider/resume_provider.dart';

class RearrangeScreen extends StatelessWidget {
  const RearrangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final sectionOrder = resumeProvider.sectionOrder;
    final allowedSections = resumeProvider.defaultSections;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rearrange Sections'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              itemCount: sectionOrder.length,
              itemBuilder: (context, index) {
                return ListTile(
                  key: Key('$index'),
                  leading: const Icon(Icons.drag_handle),
                  title: Text(sectionOrder[index]),
                );
              },
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final reorderedList = List<String>.from(sectionOrder);
                final item = reorderedList.removeAt(oldIndex);
                reorderedList.insert(newIndex, item);
                resumeProvider.saveSectionOrder(reorderedList);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Reset to default order
                resumeProvider.saveSectionOrder(allowedSections);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reset Order'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              width: 330,
              alignment: Alignment.center,
              child: Text(
                'Note: Touch & Drag the title to rearrange the sections. The order will be reflected only in the resume/cv templates and not in the profile page.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
