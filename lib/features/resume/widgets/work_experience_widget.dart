import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/custom_theme.dart';

class WorkExperienceWidget extends StatefulWidget {
  final List<WorkExperience> experiences;
  const WorkExperienceWidget({
    super.key,
    required this.experiences,
  });

  @override
  State<WorkExperienceWidget> createState() => _WorkExperienceWidgetState();
}

class _WorkExperienceWidgetState<T> extends State<WorkExperienceWidget> {
  final dateFormat = DateFormat("MMMM d, yyyy");
  List<WorkExperience> exp = [];

  @override
  void initState() {
    exp = widget.experiences;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EXPERIENCE section'.toUpperCase(),
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: blueAccent),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  exp.add(WorkExperience());
                });
              },
              icon: Icon(
                Icons.add_circle,
                color: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: exp.length,
          separatorBuilder: (_, __) => const Gap(20),
          itemBuilder: (context, index) {
            final workExp = exp[index];
            return Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Experience ${index + 1} ",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    PrimaryTextfield(
                      hintText: "Company Name",
                      label: "Company Name",
                      onSubmit: (value) {
                        workExp.designation = value;
                      },
                    ),
                    PrimaryTextfield(
                      hintText: "Position",
                      label: "Posiiton",
                      onChanged: (v) {
                        workExp.designation = v;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            // onTap: () async {
                            //   final picked = await showDatePicker(
                            //       context: context,
                            //       firstDate: DateTime(1980),
                            //       lastDate: DateTime.now());

                            //   if (picked != null) {
                            //     setState(() {
                            //       workExp?.startDate =
                            //           dateFormat.format(picked);
                            //     });
                            //   }
                            // },
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
                                      Text(workExp?.startDate != "" &&
                                              workExp?.startDate != null
                                          ? (workExp?.startDate ?? '')
                                          : 'Select Date'),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.expand_more))
                                ]),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                // onTap: workExp?.isCurrentlyWorking == true
                                //     ? null
                                //     : () async {
                                //         final picked =
                                //             await showDatePicker(
                                //                 context: context,
                                //                 firstDate: DateTime(1980),
                                //                 lastDate: DateTime.now());
                                //         if (picked != null) {
                                //           setState(() {
                                //             workExp?.endDate =
                                //                 dateFormat.format(picked);
                                //           });
                                //         }
                                //       },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'To',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          ),
                                          Text(
                                            workExp?.endDate != "" &&
                                                    workExp?.endDate != null
                                                ? (workExp?.endDate ?? "")
                                                : "Select Date",
                                            style: TextStyle(
                                              color: Colors.black,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(child: Text('Currently Working')),
                                  Checkbox(
                                    value: workExp?.isCurrentlyWorking ?? false,
                                    onChanged: (value) {
                                      // setState(() {
                                      //   workExp?.isCurrentlyWorking =
                                      //       !(workExp
                                      //               .isCurrentlyWorking ??
                                      //           false);

                                      //   workExp?.endDate =
                                      //       (workExp.isCurrentlyWorking ==
                                      //               true
                                      //           ? "Present"
                                      //           : null)!;
                                      // });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: workExp.jobResponsibilities.length,
                      itemBuilder: (context, resIndex) {
                        return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: null,
                                icon: Text("${resIndex + 1}"),
                              ),
                              Expanded(
                                child: TextFormField(
                                    validator: (value) {
                                      if (value?.isEmpty ?? false) {
                                        return 'Please enter a value';
                                      }
                                      return null;
                                    },
                                    maxLines: null,
                                    onChanged: (v) {
                                      workExp.jobResponsibilities[resIndex] = v;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Mention a job responsibilty',
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                    )),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    tooltip: 'Delete current responsibility',
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete,
                                    ),
                                    splashColor: Colors.green,
                                    iconSize: 15,
                                    color: Colors.red,
                                  ),
                                  if (resIndex ==
                                      (workExp?.jobResponsibilities.length ??
                                              0) -
                                          1)
                                    IconButton(
                                      tooltip: 'Add Responsibility',
                                      onPressed: () {
                                        // resBloc.addJobResponsibility(index);
                                      },
                                      icon: Icon(
                                        Icons.add_box_outlined,
                                      ),
                                      splashColor: Colors.green,
                                      iconSize: 15,
                                      color: Colors.green,
                                    ),
                                ],
                              )
                            ]);
                      },
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              exp.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryRed, width: 2),
                                // color: Color.fromARGB(255, 246, 102, 102),
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  color: AppColors.primaryRed,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
