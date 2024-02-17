import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';
import 'package:resume_builder/features/resume/widgets/experience_widget.dart';
import 'package:resume_builder/features/resume/widgets/profile_widget.dart';
import 'package:resume_builder/features/resume/widgets/skills_section.dart';

import '../../../core/theme/custom_theme.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  ResumeModel resume = ResumeModel(
      profile: Profile(),
      workExperience: [],
      certifications: [],
      education: [],
      skills: []);

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
                      ProfileWidget(
                        onChangedEmail: (value) {
                          resume.profile.email = value;
                        },
                        onChangedName: (value) {
                          resume.profile.name = value;
                        },
                        onChangedPhone: (value) {
                          resume.profile.phoneNumber = value;
                        },
                        onChangedPortfolio: (value) {
                          resume.profile.yourPortfolioSite = value;
                        },
                        onChangedSummary: (value) {
                          resume.profile.profileSummary = value;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EXPERIENCE section'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: blueAccent),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                resume.workExperience.add(
                                    WorkExperience(jobResponsibilities: ['']));
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
                        itemCount: resume.workExperience.length,
                        separatorBuilder: (_, __) => const Gap(20),
                        itemBuilder: (context, index) {
                          return ExperienceWidget(
                            onNameChanged: (value) {
                              resume.workExperience[index].companyName = value;
                            },
                            onPositionChanged: (value) {
                              resume.workExperience[index].designation = value;
                            },
                            onResponsibilityChanged: (resIndex, value) {
                              resume.workExperience[index]
                                  .jobResponsibilities[resIndex] = value;
                            },
                            onDeleteResponsibility: (reIndex) {
                              setState(() {
                                resume.workExperience[index].jobResponsibilities
                                    .removeAt(reIndex);
                              });
                            },
                            onAddResponsibility: () {
                              setState(() {
                                resume.workExperience[index].jobResponsibilities
                                    .add("");
                              });
                            },
                            onDeletePressed: () {
                              setState(() {
                                resume.workExperience.removeAt(index);
                              });
                            },
                            index: index,
                            experience: resume.workExperience[index],
                          );
                        },
                      ),
                      const SkillsSection(),
                      const Gap(20),
                      PrimaryButton(
                          label: "Generate Resume",
                          onPressed: () {
                            print(resume.profile?.name);
                            print(resume.profile?.phoneNumber);
                            print(resume.profile?.profileSummary);

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
