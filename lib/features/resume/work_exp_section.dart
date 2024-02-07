import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';
import 'package:resume_builder/features/resume/resume_data_bloc.dart';
import 'package:resume_builder/features/resume/textfield_widget.dart';

import '../../core/theme/custom_theme.dart';

class WorkExpSection extends StatefulWidget {
  final String sectionHeading;
  final String? firstLabel;
  final String? secondLabel;
  // final ResumeDataBloc bloc;
  const WorkExpSection(
      {super.key,
      required this.sectionHeading,
      // required this.bloc,
      required this.firstLabel,
      required this.secondLabel});

  @override
  State<WorkExpSection> createState() => _WorkExpSectionState();
}

class _WorkExpSectionState extends State<WorkExpSection> {
  final dateFormat = DateFormat("MMMM d, yyyy");



  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.maybeOf(context)?.size.width ?? 40) - 40;
    return BlocProvider.value(
      value: BlocProvider.of<ResumeDataBloc>(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.sectionHeading} Section',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: blueAccent),
              ),
              IconButton(
                onPressed: () {
                BlocProvider.of<ResumeDataBloc>(context).addExperience();
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
          BlocBuilder<ResumeDataBloc, ResumeModel?>(
            builder: (context, state) {
              print("${state?.workExperience}UI MUJI");
              return ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: state?.workExperience?.length ?? 0,
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) {
                  final workExp = state?.workExperience?[index];
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey),
                          child: Text(
                            "${widget.sectionHeading} ${index + 1} ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: TextfieldWidget(
                              controller: TextEditingController(),
                              label: '${widget.firstLabel}',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextfieldWidget(
                            controller: TextEditingController(),
                            label: '${widget.secondLabel}',
                          ),
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
                                                          workExp?.endDate !=
                                                              null
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
                                            child: Text(widget.sectionHeading
                                                    .toLowerCase()
                                                    .contains('education')
                                                ? 'Currently Studying'
                                                : 'Currently Working')),
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
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: () {
                                  // BlocProvider.of<ResumeDataBloc>(context)
                                  //     .addExperience();
                                  // setState(() {
                                  //   experiences.removeAt(index);
                                  // });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 246, 102, 102),
                                      borderRadius: BorderRadius.circular(4)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.white,
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
      ),
    );
  }
}
