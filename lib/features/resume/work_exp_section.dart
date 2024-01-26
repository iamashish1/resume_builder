import 'package:flutter/material.dart';
import 'package:resume_builder/features/resume/textfield_widget.dart';

class WorkExpSection extends StatefulWidget {
  const WorkExpSection({super.key});

  @override
  State<WorkExpSection> createState() => _WorkExpSectionState();
}

class _WorkExpSectionState extends State<WorkExpSection> {
  List<Map<String, TextEditingController>> experiences = [];
  void addExperience() {
    setState(() {
      experiences.add({
        "company": TextEditingController(),
        "position": TextEditingController(),
        "dateRange": TextEditingController(),
        "responsibilities": TextEditingController()
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            final workExp = experiences[index];
            return ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Experience ${index + 1}"),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        experiences.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete_outline_outlined),
                  )
                ],
              ),
              children: [
                TextfieldWidget(
                  maxLines: 1,
                  controller: workExp["company"],
                  label: 'Company Name',
                ),
                SizedBox(height: 10),
                TextfieldWidget(
                  maxLines: 1,
                  controller: workExp["position"],
                  label: 'Position',
                ),
                // You can add more fields here
              ],
            );
          },
        ),
        OutlinedButton(
          onPressed: addExperience,
          child: Icon(Icons.add),
        ),
        OutlinedButton(
            onPressed: () {
              print(experiences[0]['company']?.text);
              experiences.map((e) {
                print('HEY');
                print(e['position']?.text.toString());
                print(e['company']?.text);
              });
            },
            child: Icon(Icons.save))
      ],
    );
  }
}
