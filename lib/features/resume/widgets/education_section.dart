import 'package:flutter/material.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';


class EducationWidget extends StatefulWidget {
  final Education? education;
  final int index;
  final void Function()? onDeletePressed;
  final void Function(bool?)? isCurrentlyStudying;
  final void Function()? onFromDate;
  final void Function()? onToDate;
  final void Function(String)? onInstitutionChanged;
  final void Function(String)? onCourseChanged;
  const EducationWidget({
    super.key,
    this.education,
    required this.index,
    this.onDeletePressed,
    this.onInstitutionChanged,
    this.onCourseChanged,
    this.isCurrentlyStudying,
    this.onFromDate,
    this.onToDate,
  });

  @override
  State<EducationWidget> createState() => _EducationWidgetState();
}

class _EducationWidgetState<T> extends State<EducationWidget> {
  final nameFocus = FocusNode();
  final courseFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.maybeOf(context)?.size.width ?? 40) - 40;
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Education ${widget.index + 1} ",
            style: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: PrimaryTextfield(
                  hintText: "Institution Name",
                  label: 'Institution Name',
                  focusNode: nameFocus,
                  nextFocus: courseFocus,
                  onChanged: widget.onInstitutionChanged),
            ),
            const SizedBox(height: 10),
            PrimaryTextfield(
                hintText: "Program/Course",
                label: 'Program/Course',
                focusNode: courseFocus,
                onChanged: widget.onCourseChanged),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: widget.onFromDate,
                  child: SizedBox(
                    width: width / 2,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'From',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              Text(widget.education?.startDate != "" &&
                                      widget.education?.startDate != null
                                  ? (widget.education?.startDate ?? '')
                                  : 'Select Date'),
                            ],
                          ),
                          const IconButton(
                              onPressed: null, icon: Icon(Icons.expand_more))
                        ]),
                  ),
                ),
                SizedBox(
                  width: width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: widget.onToDate,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'To',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  Text(
                                    widget.education?.endDate != "" &&
                                            widget.education?.endDate != null
                                        ? (widget.education?.endDate ?? "")
                                        : "Select Date",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.expand_more))
                            ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Flexible(child: Text('Currently Studying')),
                          Checkbox(
                            value:
                                widget.education?.isCurrentlyStudying ?? false,
                            onChanged: (value) {
                              widget.isCurrentlyStudying?.call(value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: widget.onDeletePressed,
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.primaryRed, width: 2),
                        // color: Color.fromARGB(255, 246, 102, 102),
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text(
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
  }
}
