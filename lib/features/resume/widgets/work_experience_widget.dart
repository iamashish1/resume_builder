import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/features/resume/bloc/resume_data_bloc.dart';
import 'package:resume_builder/features/resume/widgets/skills_section.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/custom_theme.dart';
import '../../home/template_model/template_model.dart';

class WorkExperienceWidget extends StatefulWidget {
  const WorkExperienceWidget({
    super.key,
  });

  @override
  State<WorkExperienceWidget> createState() => _WorkExperienceWidgetState();
}

class _WorkExperienceWidgetState<T> extends State<WorkExperienceWidget> {
  final dateFormat = DateFormat("MMMM d, yyyy");

  @override
  Widget build(BuildContext context) {
    final resBloc = BlocProvider.of<ResumeDataBloc>(context);
    final double width = (MediaQuery.maybeOf(context)?.size.width ?? 40) - 40;
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
                resBloc.addExperience();
              },
              icon: Icon(
                Icons.add_circle,
                color: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
        BlocBuilder<ResumeDataBloc, ResumeModel?>(
          builder: (context, state) {
            return ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: state?.workExperience?.length ?? 0,
              separatorBuilder: (_, __) => const Gap(20),
              itemBuilder: (context, index) {
                final workExp = state?.workExperience?[index];
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
                        // Padding(
                        //   padding: EdgeInsets.only(top: 3),
                        //   child: TextfieldWidget(
                        //     controller: TextEditingController(),
                        //     label: '${widget.firstLabel}',
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        PrimaryTextfield(
                          hintText: "Company Name",
                          label: "Company Name",
                          onSubmit: (value) {
                            resBloc.addCompanyName(value, index);
                          },
                        ),
                        PrimaryTextfield(
                          hintText: "Position",
                          label: "Posiiton",
                        ),
                        // TextfieldWidget(
                        //   controller: TextEditingController(),
                        //   label: '${widget.secondLabel}',
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
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
                              child: Container(
                                width: width / 2,
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
                                                color: Colors.grey,
                                                fontSize: 10),
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
                            Container(
                              width: width / 2,
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
                                      Flexible(
                                          child: Text('Currently Working')),
                                      Checkbox(
                                        value: workExp?.isCurrentlyWorking ??
                                            false,
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
                          itemCount: workExp?.jobResponsibilities.length,
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
                                        decoration: InputDecoration(
                                          hintText:
                                              'Mention a job responsibilty',
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none,
                                        )),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        tooltip:
                                            'Delete current responsibility',
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.delete,
                                        ),
                                        splashColor: Colors.green,
                                        iconSize: 15,
                                        color: Colors.red,
                                      ),
                                      if (resIndex ==
                                          (workExp?.jobResponsibilities
                                                      .length ??
                                                  0) -
                                              1)
                                        IconButton(
                                          tooltip: 'Add Responsibility',
                                          onPressed: () {
                                            resBloc.addJobResponsibility(index);
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
                              onTap: () {},
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
            );
          },
        ),
      ],
    );
  }
}
