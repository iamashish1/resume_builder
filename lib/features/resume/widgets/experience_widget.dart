import 'package:flutter/material.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

class ExperienceWidget extends StatefulWidget {
  final WorkExperience? experience;
  final int index;
  final void Function()? onDeletePressed;
  final void Function()? onAddResponsibility;
  final void Function(int)? onDeleteResponsibility;
  final void Function(bool?)? onCurrentlyWorking;
  final void Function()? onFromDate;
  final void Function()? onToDate;
  final void Function(int, String)? onResponsibilityChanged;
  final void Function(String)? onNameChanged;
  final void Function(String)? onPositionChanged;

  const ExperienceWidget(
      {super.key,
      required this.experience,
      required this.index,
      this.onDeletePressed,
      this.onAddResponsibility,
      this.onDeleteResponsibility,
      this.onCurrentlyWorking,
      this.onFromDate,
      this.onToDate,
      this.onNameChanged,
      this.onPositionChanged,
      this.onResponsibilityChanged});

  @override
  State<ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget> {
  final nameFocus = FocusNode();
  final positionFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Experience ${widget.index + 1} ",
            style: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 10),
            PrimaryTextfield(
                controller:
                    TextEditingController(text: widget.experience?.companyName),
                hintText: "Company Name",
                label: "Company Name",
                focusNode: nameFocus,
                nextFocus: positionFocus,
                onChanged: widget.onNameChanged),
            PrimaryTextfield(
                controller:
                    TextEditingController(text: widget.experience?.designation),
                hintText: "Position",
                label: "Posiiton",
                focusNode: positionFocus,
                onChanged: widget.onPositionChanged),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: widget.onFromDate,
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
                              Text(widget.experience?.startDate != "" &&
                                      widget.experience?.startDate != null
                                  ? (widget.experience?.startDate ?? '')
                                  : 'Select Date'),
                            ],
                          ),
                          const IconButton(
                              onPressed: null, icon: Icon(Icons.expand_more))
                        ]),
                  ),
                ),
                Expanded(
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
                                    widget.experience?.endDate != "" &&
                                            widget.experience?.endDate != null
                                        ? (widget.experience?.endDate ?? "")
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
                          const Flexible(child: Text('Currently Working')),
                          Checkbox(
                              value: widget.experience?.isCurrentlyWorking ??
                                  false,
                              onChanged: widget.onCurrentlyWorking),
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
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: widget.experience?.jobResponsibilities.length,
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
                            controller: TextEditingController(
                                text: widget
                                    .experience?.jobResponsibilities[resIndex]),
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            maxLines: null,
                            onChanged: (value) {
                              //Function.apply is a static method on Function
                              //It is like call() but slightly more flexible
                              widget.onResponsibilityChanged
                                  ?.call(resIndex, value);
                            },
                            decoration: const InputDecoration(
                              hintText: 'Mention a job responsibilty',
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            )),
                      ),
                      Column(
                        children: [
                          IconButton(
                            tooltip: 'Delete current responsibility',
                            onPressed: () {
                              widget.onDeleteResponsibility!(resIndex);
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                            splashColor: Colors.green,
                            iconSize: 15,
                            color: Colors.red,
                          ),
                          if (resIndex ==
                              (widget.experience?.jobResponsibilities.length ??
                                      0) -
                                  1)
                            IconButton(
                              tooltip: 'Add Responsibility',
                              icon: const Icon(
                                Icons.add_box_outlined,
                              ),
                              splashColor: Colors.green,
                              iconSize: 15,
                              color: Colors.green,
                              onPressed: widget.onAddResponsibility,
                            ),
                        ],
                      )
                    ]);
              },
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
