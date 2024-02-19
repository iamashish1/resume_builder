import 'package:flutter/material.dart';
import 'package:resume_builder/features/authentication/presentation/widgets/authentication_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return const AuthenticationPage(
      isSignIn: true,
    );
  }
}
