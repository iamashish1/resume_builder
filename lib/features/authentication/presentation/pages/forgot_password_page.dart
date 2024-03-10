import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:resume_builder/core/constants/app_constants.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Forgot Password",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                PrimaryTextfield(
                    validator: (v) {
                      if (emailRegex.hasMatch(v ?? "")) {
                        return null;
                      } else {
                        return ('Enter valid email');
                      }
                    },
                    controller: email,
                    hintText: "Enter your email"),
                const Gap(20),
                PrimaryButton(
                  isLoading: false,
                    label: "Reset Password",
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                            email.clear();

                          Fluttertoast.showToast(
                              msg: "Check email to reset password!");
                        } catch (_) {
                          Fluttertoast.showToast(msg: "Something went wrong!");
                        }
                      }
                    })
              ],
            )),
      ),
    );
  }
}
