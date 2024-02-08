import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';
import 'package:resume_builder/features/resume/bloc/resume_data_bloc.dart';
import 'package:resume_builder/features/resume/textfield_widget.dart';

import '../../../core/theme/custom_theme.dart';

class EducationWidget extends StatefulWidget {
  const EducationWidget({
    super.key,
  });

  @override
  State<EducationWidget> createState() => _EducationWidgetState();
}

class _EducationWidgetState<T> extends State<EducationWidget> {
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
                'Education Section'.toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: blueAccent),
              ),
              IconButton(
                onPressed: () {
                  BlocProvider.of<ResumeDataBloc>(context).addEducation();
                },
                icon: Icon(Icons.add_circle,color: AppColors.primaryGreen,),
              ),
            ],
          ),
          BlocBuilder<ResumeDataBloc, ResumeModel?>(
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: state?.education?.length ?? 0,
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) {
                  final workExp = state?.education?[index];
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Education ${index + 1} ",
                          style: TextStyle(
                               color: Colors.blueGrey,
                              fontWeight: FontWeight.w400,),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: PrimaryTextfield(
                              hintText: "Institution Name",
                              label: 'Proram Course',
                            ),
                          ),
                          const SizedBox(height: 10),
                          PrimaryTextfield(
                            hintText: "Program/Course",
                            label: 'Program/Course',
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
                                child: SizedBox(
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
                              SizedBox(
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
                                            child: Text('Currently Studying')),
                                        Checkbox(
                                          value: workExp?.isCurrentlyStudying ??
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
                           
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color:AppColors.primaryRed,width: 2 ),
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
      ),
    );
  }
}
