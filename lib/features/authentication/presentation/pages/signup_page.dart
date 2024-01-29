import 'package:flutter/material.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signin_page.dart';
import 'package:resume_builder/features/home/homepage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: const Text('Resume Builder App')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'We are pleased to have you onboard \n It only takes one click to SIGN UP!'),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  hintText: 'Email'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  hintText: 'Password'),
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Homepage()));
                },
                child: Text('Sign Up')),
            Text('Already a member?'),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SigninPage()));
                },
                child: Text('Sign in')),
            Text('OR'),
            ElevatedButton.icon(
                icon: Image.asset(
                  'assets/google_icon.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () async {
                  // final result = await signInWithGoogle();
                },
                label: Text('Continue with google'))
          ],
        ),
      ),
    );
  }
}