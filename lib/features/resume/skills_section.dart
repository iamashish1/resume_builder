import 'package:flutter/material.dart';
import 'package:resume_builder/core/theme/custom_theme.dart';
import './textfield_widget.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  List<TextEditingController> skills = [];
  addNewSkills() {
    skills.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Skills Section',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: blueAccent),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  addNewSkills();
                });
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: skills.length,
          itemBuilder: (context, index) {
            final skill = skills[index];
            return Container(
              // color: Colors.red ,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      skills.removeAt(index);
                    });
                  },
                  icon: Icon(
                    Icons.clear,
                  ),
                  splashColor: Colors.green,
                  iconSize: 12,
                  color: Colors.deepOrangeAccent,
                ),
                Expanded(
                  child: TextFormField(
                      controller: skill,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Mention a skill',
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      )),
                )
              ]),
            );
          },
        ),
      ],
    );
  }
}
