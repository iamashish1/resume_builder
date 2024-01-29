import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/features/resume/textfield_widget.dart';

class WorkExpSection extends StatefulWidget {
  const WorkExpSection({super.key});

  @override
  State<WorkExpSection> createState() => _WorkExpSectionState();
}

class _WorkExpSectionState extends State<WorkExpSection> {
  List<Map<String, dynamic>> experiences = [];
  final dateFormat = DateFormat("MMMM d, yyyy");

  void addExperience() {
    setState(() {
      experiences.add({
        "company": TextEditingController(),
        "position": TextEditingController(),
        "startDate": "",
        "endDate": "",
        "isCurrentlyWorking": false,
        "responsibilities": ""
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.maybeOf(context)?.size.width ?? 40) - 40;
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
                const SizedBox(height: 10),
                TextfieldWidget(
                  maxLines: 1,
                  controller: workExp["position"],
                  label: 'Position',
                ),
             
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1980),
                            lastDate: DateTime.now());

                        if (picked != null) {
                          setState(() {
                            workExp["startDate"] = dateFormat.format(picked);
                          });
                        }
                      },
                      child: Container(
                        width: width / 2,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'From',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  Text(workExp["startDate"] != ""
                                      ? workExp["startDate"]
                                      : 'Start Date'),
                                ],
                              ),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.expand_more))
                            ]),
                      ),
                    ),
                    Container(
                      width: width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: workExp["isCurrentlyWorking"]
                                ? null
                                : () async {
                                    final picked = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1980),
                                        lastDate: DateTime.now());

                                    if (picked != null) {
                                      setState(() {
                                        workExp["endDate"] =
                                            dateFormat.format(picked);
                                      });
                                    }
                                  },
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'From',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                      Text(
                                        workExp["endDate"] != ""
                                            ? workExp["endDate"]
                                            : 'End Date:',
                                        style: TextStyle(
                                          decoration:
                                              workExp["isCurrentlyWorking"]
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.expand_more))
                                ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(child: Text('Currently working')),
                              Checkbox(
                                value: workExp["isCurrentlyWorking"],
                                onChanged: (value) {
                                  setState(() {
                                    workExp["isCurrentlyWorking"] =
                                        !workExp["isCurrentlyWorking"];
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          experiences.removeAt(index);
                        });
                      },
                      child: Text(
                        "Delete Experience",
                        style: TextStyle(color: Colors.redAccent),
                      )),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
