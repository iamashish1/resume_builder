import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/theme/custom_theme.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';
import 'package:resume_builder/features/resume/bloc/resume_data_bloc.dart';
import 'package:resume_builder/features/resume/pages/resume_preview_page.dart';
import 'package:resume_builder/features/resume/widgets/education_section.dart';
import 'package:resume_builder/features/resume/widgets/skills_section.dart';
import 'package:resume_builder/features/resume/widgets/work_experience_widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final phoneNumber = TextEditingController();

  final email = TextEditingController();

  final yourPortfolioSite = TextEditingController();

  final profileSummary = TextEditingController();
  //WORK EXP CONTROLLERS
  final companyController = TextEditingController();
  final positionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResumeDataBloc>(
      create: (BuildContext context) {
        return ResumeDataBloc();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          'Enter details',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
        )),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profile Section'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // TextfieldWidget(
                        //   controller: nameController,
                        //   hintText: 'John Doe',
                        //   label: 'Name',
                        // ),
                        PrimaryTextfield(
                          label: "Name",
                          hintText: 'Enter your name',
                          controller: nameController,
                        ),
                        SizedBox(height: 10),
                        PrimaryTextfield(
                          label: "Phone number",
                          hintText: 'Enter your phone number',
                          controller: phoneNumber,
                        ),
                        SizedBox(height: 10),
                        PrimaryTextfield(
                          label: "Email",
                          hintText: 'Enter your email',
                          controller: email,
                        ),
                        SizedBox(height: 10),
                        PrimaryTextfield(
                          label: "Portfolio",
                          hintText: 'Enter your portfolio site',
                          controller: yourPortfolioSite,
                        ),
                        const SizedBox(height: 10),
                        PrimaryTextfield(
                          label: "Summary",
                          controller: profileSummary,
                          maxLines: 3,
                          hintText:
                              'I am an experienced and highly motivated ...',
                          // label: 'Profile summary',
                        ),
                        const WorkExperienceWidget(),
                        const EducationWidget(
                            // sectionHeading: 'Education',
                            // firstLabel: 'Institution name',
                            // secondLabel: 'Program/Course',
                            ),
                        SkillsSection(),
                        SizedBox(height: 20),
                        PrimaryButton(
                            label: "Generate Resume", onPressed: () {})
                        // Align(
                        //   alignment: Alignment.center,
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       if (_formKey.currentState!.validate()) {
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //             builder: (context) => ResumePreview(
                        //                   resume: ResumeModel(),
                        //                 )));
                        //       }
                        //     },
                        //     child: const Text(
                        //       'Generate Resume',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
