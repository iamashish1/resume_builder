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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Work Experience'),
            IconButton(
              onPressed: addExperience,
              icon: Icon(Icons.add),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            final workExp = experiences[index];
            return ExpansionTile(
              tilePadding: EdgeInsets.symmetric(horizontal: 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Experience ${index + 1}"),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        experiences.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete_outline_outlined),
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
