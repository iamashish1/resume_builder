import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';
import 'package:resume_builder/features/resume/widgets/skills_section.dart';
import 'package:resume_builder/features/resume/widgets/work_experience_widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  List<WorkExperience> experiences = [];
  List<Education> education = [];
  List<String> skills = [];
  List<String> certifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
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
                  padding: const EdgeInsets.all(18),
                  child: Column(
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
                        label: "Name",
                        hintText: 'Enter your name',
                        onChanged: (val) {
                          profile.name = val;
                        },
                      ),
                      const Gap(10),
                      PrimaryTextfield(
                        label: "Phone number",
                        hintText: 'Enter your phone number',
                        onChanged: (val) {
                          profile.phoneNumber = val;
                        },
                      ),
                      const Gap(10),
                      PrimaryTextfield(
                        label: "Email",
                        hintText: 'Enter your email',
                        onChanged: (val) {
                          profile.email = val;
                        },
                      ),
                      const Gap(10),
                      PrimaryTextfield(
                        label: "Portfolio",
                        hintText: 'Enter your portfolio site',
                        onChanged: (val) {
                          profile.yourPortfolioSite = val;
                        },
                      ),
                      const Gap(10),
                      PrimaryTextfield(
                        label: "Summary",
                        maxLines: 3,
                        onChanged: (val) {
                          profile.profileSummary = val;
                        },
                        hintText:
                            'I am an experienced and highly motivated ...',
                        // label: 'Profile summary',
                      ),
                      WorkExperienceWidget(
                        experiences: experiences,
                      ),
                      const SkillsSection(),
                      const Gap(20),
                      PrimaryButton(
                          label: "Generate Resume",
                          onPressed: () {
                           
                              print(experiences.map((e){
                                print(e.companyName);
                                print(e.designation);
                              }));
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => ResumePreview(
                              //           resume: ResumeModel(
                              //               workExperience: experiences,
                              //               profile: profile),
                              //         )));
                            
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
