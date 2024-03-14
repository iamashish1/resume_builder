import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';

class ProfileWidget extends StatefulWidget {
  final Function(String)? onChangedName;
  final Function(String)? onChangedEmail;
  final Function(String)? onChangedPhone;
  final Function(String)? onChangedPortfolio;
  final Function(String)? onChangedSummary;
  final Function(String)? onChangedTitle;
  const ProfileWidget(
      {super.key,
      this.onChangedName,
      this.onChangedEmail,
      this.onChangedPhone,
      this.onChangedPortfolio,
      this.onChangedSummary,
      this.onChangedTitle});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final FocusNode njNode = FocusNode();

  final FocusNode nNode = FocusNode();
  final FocusNode pNode = FocusNode();
  final FocusNode eNode = FocusNode();
  final FocusNode poNode = FocusNode();
  final FocusNode sNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Section'.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(5),
        PrimaryTextfield(
          label: "Job Title",
          hintText: 'Enter your job title',
          focusNode: njNode,
          onChanged: widget.onChangedTitle,
          nextFocus: nNode,
        ),
        const Gap(10),
        PrimaryTextfield(
          label: "Name",
          hintText: 'Enter your name',
          focusNode: nNode,
          onChanged: widget.onChangedName,
          nextFocus: pNode,
        ),
        const Gap(10),
        PrimaryTextfield(
            label: "Phone number",
            hintText: 'Enter your phone number',
            nextFocus: eNode,
            focusNode: pNode,
            onChanged: widget.onChangedPhone),
        const Gap(10),
        PrimaryTextfield(
            label: "Email",
            hintText: 'Enter your email',
            nextFocus: poNode,
            focusNode: eNode,
            onChanged: widget.onChangedEmail),
        const Gap(10),
        PrimaryTextfield(
            label: "Portfolio",
            hintText: 'Enter your portfolio site',
            focusNode: poNode,
            nextFocus: sNode,
            validator: (value) {
              return null;
            },
            onChanged: widget.onChangedPortfolio),
        const Gap(10),
        PrimaryTextfield(
          label: "Summary",
          maxLines: 3,
          focusNode: sNode,
          onChanged: widget.onChangedSummary,
          hintText: 'I am an experienced and highly motivated ...',
          // label: 'Profile summary',
        ),
      ],
    );
  }
}
