import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_builder/core/theme/custom_theme.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';
import 'package:resume_builder/features/resume/resume_data_bloc.dart';
import 'package:resume_builder/features/resume/resume_preview_page.dart';
import 'package:resume_builder/features/resume/skills_section.dart';
import 'package:resume_builder/features/resume/textfield_widget.dart';
import 'package:resume_builder/features/resume/work_exp_section.dart';

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
                          'Profile Section',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: blueAccent),
                        ),
                        SizedBox(height: 5),
                        TextfieldWidget(
                          controller: nameController,
                          hintText: 'John Doe',
                          label: 'Name',
                        ),
                        SizedBox(height: 10),
                        TextfieldWidget(
                          controller: phoneNumber,
                          hintText: 'xxx-xxx-xxx',
                          label: 'Phone Number',
                        ),
                        SizedBox(height: 10),
                        TextfieldWidget(
                          controller: email,
                          hintText: 'someone@xyz.com',
                          label: 'Email',
                        ),
                        SizedBox(height: 10),
                        TextfieldWidget(
                          doNotValidate: true,
                          controller: yourPortfolioSite,
                          hintText: 'yourname.xyz.com',
                          label: 'Your Portfolio Site',
                        ),
                        SizedBox(height: 10),
                        TextfieldWidget(
                          controller: profileSummary,
                          maxLines: 3,
                          hintText:
                              'I am an experienced and highly motivated ...',
                          label: 'Profile summary',
                        ),
                        WorkExpSection(
                          // bloc: BlocProvider.of<ResumeDataBloc>(context),
                          sectionHeading: 'Experience',
                          firstLabel: 'Company Name',
                          secondLabel: 'Position',
                        ),
                        WorkExpSection(
                          // bloc: BlocProvider.of<ResumeDataBloc>(context),
                          sectionHeading: 'Education',
                          firstLabel: 'Institution name',
                          secondLabel: 'Program/Course',
                        ),
                        SkillsSection(),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ResumePreview(
                                          resume: ResumeModel(),
                                        )));
                              }
                            },
                            child: const Text(
                              'Generate Resume',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
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
