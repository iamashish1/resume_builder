import 'package:flutter/material.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/theme/custom_theme.dart';

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
              'Skills Section'.toUpperCase(),
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: blueAccent),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  addNewSkills();
                });
              }, icon: Icon(Icons.add_circle,color: AppColors.primaryGreen,), 
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: skills.length,
          itemBuilder: (context, index) {
            final skill = skills[index];
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
             
              IconButton(onPressed: null, icon:  Text("${index + 1}"),),
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
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    skills.removeAt(index);
                  });
                },
                icon: Icon(
                  Icons.delete,
                ),
                splashColor: Colors.green,
                iconSize: 15,
                color: Colors.grey,
              ),
            ]);
          },
        ),
      ],
    );
  }
}
