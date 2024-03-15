import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:resume_builder/core/ads/show_interstitial_ads.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';
import 'package:resume_builder/features/resume/pages/resume_preview_page.dart';
import 'package:resume_builder/features/resume/widgets/education_section.dart';
import 'package:resume_builder/features/resume/widgets/experience_widget.dart';
import 'package:resume_builder/features/resume/widgets/profile_widget.dart';
import 'package:resume_builder/features/resume/widgets/skills_section.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/custom_theme.dart';

class FormPage extends StatefulWidget {
  final int id;
  const FormPage({super.key, required this.id});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late ResumeModel resume;

  @override
  void initState() {
    resume = ResumeModel(
        id: widget.id,
        profile: Profile(),
        workExperience: [],
        education: [],
        skills: []);
    super.initState();
  }

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
                        onChangedTitle: (value) {
                          resume.profile.title = value.trim();
                        },
                        onChangedEmail: (value) {
                          resume.profile.email = value.trim();
                        },
                        onChangedName: (value) {
                          resume.profile.name = value.trim();
                        },
                        onChangedPhone: (value) {
                          resume.profile.phoneNumber = value.trim();
                        },
                        onChangedPortfolio: (value) {
                          resume.profile.yourPortfolioSite = value.trim();
                        },
                        onChangedSummary: (value) {
                          resume.profile.profileSummary = value.trim();
                        },
                      ),

                      //START OF WORK EXPERIENCE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EXPERIENCE section'.toUpperCase(),
                            style: const TextStyle(
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
                            icon: const Icon(
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
                            onCurrentlyWorking: (value) {
                              setState(() {
                                resume.workExperience[index]
                                        .isCurrentlyWorking =
                                    !(resume.workExperience[index]
                                        .isCurrentlyWorking);
                                if (resume.workExperience[index]
                                        .isCurrentlyWorking ==
                                    true) {
                                  resume.workExperience[index].endDate =
                                      "Present";
                                } else {
                                  resume.workExperience[index].endDate = "";
                                }
                              });
                            },
                            onFromDate: () async {
                              final picked = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1980),
                                  lastDate: DateTime.now());

                              if (picked != null) {
                                setState(() {
                                  resume.workExperience[index].startDate =
                                      dateFormat.format(picked);
                                });
                              }
                            },
                            onToDate: resume.workExperience[index]
                                        .isCurrentlyWorking ==
                                    true
                                ? null
                                : () async {
                                    final picked = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1980),
                                        lastDate: DateTime.now());
                                    if (picked != null) {
                                      setState(() {
                                        resume.workExperience[index].endDate =
                                            dateFormat.format(picked);
                                      });
                                    }
                                  },
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
                              if (resume.workExperience[index]
                                      .jobResponsibilities.length !=
                                  1) {
                                setState(() {
                                  resume
                                      .workExperience[index].jobResponsibilities
                                      .removeAt(reIndex);
                                });
                              }
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

                      //END OF WORK EXPERIENCE

                      //START OF EDUCATION
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Education section'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: blueAccent),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                resume.education.add(Education());
                              });
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),

                      ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: resume.education.length,
                        separatorBuilder: (_, __) => const Gap(20),
                        itemBuilder: (context, index) {
                          return EducationWidget(
                            isCurrentlyStudying: (value) {
                              setState(() {
                                resume.education[index].isCurrentlyStudying =
                                    !(resume
                                        .education[index].isCurrentlyStudying);
                                if (resume
                                        .education[index].isCurrentlyStudying ==
                                    true) {
                                  resume.education[index].endDate = "Present";
                                } else {
                                  resume.education[index].endDate = "";
                                }
                              });
                            },
                            onFromDate: () async {
                              final picked = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1980),
                                  lastDate: DateTime.now());

                              if (picked != null) {
                                setState(() {
                                  resume.education[index].startDate =
                                      dateFormat.format(picked);
                                });
                              }
                            },
                            onToDate:
                                resume.education[index].isCurrentlyStudying ==
                                        true
                                    ? null
                                    : () async {
                                        final picked = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1980),
                                            lastDate: DateTime.now());
                                        if (picked != null) {
                                          setState(() {
                                            resume.education[index].endDate =
                                                dateFormat.format(picked);
                                          });
                                        }
                                      },
                            onCourseChanged: (value) {
                              resume.education[index].studyCourse = value;
                            },
                            onInstitutionChanged: (value) {
                              resume.education[index].university = value;
                            },
                            onDeletePressed: () {
                              setState(() {
                                resume.education.removeAt(index);
                              });
                            },
                            index: index,
                            education: resume.education[index],
                          );
                        },
                      ),

                      //END OF EDUCATION SECTION

                      //SKILLS SECTION
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Skills Section'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: blueAccent),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                resume.skills.add("");
                              });
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: resume.skills.length,
                        itemBuilder: (context, index) {
                          return SkillsSection(
                            index: index,
                            onSkillDeleted: (i) {
                              setState(() {
                                resume.skills.removeAt(i);
                              });
                            },
                            onChnaged: (value, i) {
                              resume.skills[i] = value;
                            },
                            skill: resume.skills[index],
                          );
                        },
                      ),

                      //END OF SKILLS SECTION

                      const Gap(20),
                      PrimaryButton(
                          isLoading: false,
                          label: "Generate Resume",
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ResumePreview(resume: resume)));

                              showInterstitialAd();
                            }
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
