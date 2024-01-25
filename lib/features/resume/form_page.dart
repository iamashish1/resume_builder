import 'package:flutter/material.dart';
import 'package:resume_builder/features/home/resume_preview_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter details')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Form(
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
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: profileSummary,
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    label: Text('Profile Summary'),
                    hintText: 'I am an experienced and highly motivated ...',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: () {
                   Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ResumePreview()));
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
