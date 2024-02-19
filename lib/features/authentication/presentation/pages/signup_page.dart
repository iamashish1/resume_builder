import 'package:flutter/material.dart';
import 'package:resume_builder/features/authentication/presentation/widgets/authentication_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return const AuthenticationPage(isSignIn: false);
  }
}
