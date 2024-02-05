import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/features/resume/textfield_widget.dart';

import '../../core/theme/custom_theme.dart';

class WorkExpSection extends StatefulWidget {
  final String sectionHeading;
  final String? firstLabel;
  final String? secondLabel;
  const WorkExpSection(
      {super.key,
      required this.sectionHeading,
      required this.firstLabel,
      required this.secondLabel});

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
            Text(
              '${widget.sectionHeading} Section',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: blueAccent),
            ),
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
              tilePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.sectionHeading} ${index + 1} ",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 3, 41, 4),
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: TextfieldWidget(
                    controller: workExp["company"],
                    label: '${widget.firstLabel}',
                  ),
                ),
                const SizedBox(height: 10),
                TextfieldWidget(
                  controller: workExp["position"],
                  label: '${widget.secondLabel}',
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
                              Flexible(
                                  child: Text(widget.sectionHeading
                                          .toLowerCase()
                                          .contains('education')
                                      ? 'Currently Studying'
                                      : 'Currently Working')),
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
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          experiences.removeAt(index);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 246, 102, 102),
                            borderRadius: BorderRadius.circular(4)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
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
