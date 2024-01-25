import 'package:flutter/material.dart';
import 'package:resume_builder/features/resume/textfield_widget.dart';

class WorkExpSection extends StatefulWidget {
  const WorkExpSection({super.key});

  @override
  State<WorkExpSection> createState() => _WorkExpSectionState();
}

class _WorkExpSectionState extends State<WorkExpSection> {
  List experiences = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
              )),
          child: Column(
            children: [
              TextfieldWidget(
                maxLines: 1,
                  controller: TextEditingController(), label: 'Company Name'),
                  SizedBox(height: 10,),
              TextfieldWidget(
                  controller: TextEditingController(), label: 'Position'),
            ],
          ),
        ),
        //
        OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text('Add experience'))
      ],
    );
  }
}
