import 'package:flutter/material.dart';
import 'package:resume_builder/features/resume/resume_preview_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter details')),
      body: SafeArea(
        child: Form(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Profile Section'),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          label: Text('Name'),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: phoneNumber,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          label: Text('Phone Number'),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          label: Text('Email'),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: yourPortfolioSite,
                        decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            label: Text('Your Portfolio Site'),
                            hintText: 'yourname.xyz.com',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(height: 10),
                      TextfieldWidget(
                        controller: profileSummary,
                        maxLines: 3,
                        hintText:
                            'I am an experienced and highly motivated ...',
                        label: 'Profile summary',
                      ),
                      WorkExpSection()
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ResumePreview()));
                },
                child: const Text('Generate Resume'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
