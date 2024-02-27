import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/core/widgets/social_login_button.dart';
import 'package:resume_builder/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signin_page.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signup_page.dart';
import 'package:resume_builder/features/home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPage extends StatefulWidget {
  final bool isSignIn;
  const AuthenticationPage({
    super.key,
    required this.isSignIn,
  });

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  bool obscureText = true;
  Future<void> addUserToFirestore(User? user) async {
    // Reference to Firestore collection
    final usersCollection = FirebaseFirestore.instance.collection('users');

    // Create user document in Firestore
    await usersCollection.doc(user?.uid).set({
      'uid': user?.uid,
      'name': user?.displayName,
      'email': user?.email,
      'profile_picture': user?.photoURL,
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (firebaseException) {
      throw (AppException(
          code: firebaseException.code, message: firebaseException.message));
    } catch (error) {
      throw (AppException(code: 'NO_ERR_CODE', message: 'UNKNOWN EXCEPTION'));
    }
  }

  final _formKey = GlobalKey<FormState>();

  late bool isSignInpage;

  @override
  void initState() {
    isSignInpage = widget.isSignIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => isSignInpage
                                ? const SignupPage()
                                : const SigninPage()));
                  },
                  child: Text(
                    isSignInpage ? 'Signup' : 'Login',
                    style:
                        TextStyle(fontSize: 16, color: AppColors.primaryGreen),
                  )),
            ),
          ],
          title: Text(
            isSignInpage ? 'Login' : 'Sign up',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          )),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              PrimaryTextfield(
                  controller: email,
                  hintText: 'Email',
                  focusNode: emailFocus,
                  nextFocus: passwordFocus),
              SizedBox(
                height: 20,
              ),
              PrimaryTextfield(
                controller: password,
                isObscure: obscureText,
                hintText: 'Password',
                focusNode: passwordFocus,
                suffix: InkWell(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Text(
                    "Show",
                    style: TextStyle(
                        color: Color(0xff5DB075), fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                label: isSignInpage ? 'Login' : 'Signup',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.isSignIn == true) {
                      try {
                        final user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text.trim(),
                                password: password.text.trim());

                        //SAVE TO SAHREDPREFS

                        final pref = await SharedPreferences.getInstance();

                        pref.setString("user", user.toString());

                        //END SHAREDPREFS
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homepage()));

                        //
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          Fluttertoast.showToast(
                            msg: "No user found for that email.",
                          );
                        } else if (e.code == 'invalid-email') {
                          Fluttertoast.showToast(msg: "The email is invalid.");
                        } else if (e.code == 'wrong-password') {
                          Fluttertoast.showToast(
                            msg: "Wrong password provided for that user.",
                          );
                        } else if (e.code == 'too-many-requests') {
                          Fluttertoast.showToast(
                            msg: "Slow down- Too many requests.",
                          );
                        } else if (e.code == "user-disabled") {
                          Fluttertoast.showToast(
                            msg: "The user has been disabled by admin.",
                          );
                        } else if (e.code == 'operation-not-allowed') {
                          Fluttertoast.showToast(
                            msg: "The user has been disabled by admin.",
                          );
                        }
                      }
                    } else {
                      try {
                        final user = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email.text.trim(),
                                password: password.text.trim());

                        //SAVE TO SAHREDPREFS

                        final pref = await SharedPreferences.getInstance();

                        pref.setString("user", user.toString());

                        //END SHAREDPREFS
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homepage()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          Fluttertoast.showToast(
                            msg: "Email already in use.",
                          );
                        } else if (e.code == 'weak-password') {
                          Fluttertoast.showToast(
                            msg: "The password is too weak.",
                          );
                        } else if (e.code == 'invalid-email') {
                          Fluttertoast.showToast(msg: "The email is invalid.");
                        }
                      }
                    }
                  }
                },
              ),
              const Gap(10),
              if (isSignInpage)
                InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                    },
                    child: const Text(
                      "Forgot your password?",
                      style: TextStyle(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w600),
                    )),
              SizedBox(
                height: 20,
              ),
              // Text('Not a member?'),
              Text(
                'Or use google login:',
                style: TextStyle(color: Color.fromARGB(255, 122, 120, 120)),
              ),

              SizedBox(
                height: 20,
              ),

              SocialLoginButton(
                onTap: () async {
                  try {
                    final user = await signInWithGoogle();
                    //SAVE TO SAHREDPREFS

                    final pref = await SharedPreferences.getInstance();

                    pref.setString("user", user.toString());

                    //END SHAREDPREFS
                    if (mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homepage()));
                    }
                  } catch (_) {
                    Fluttertoast.showToast(msg: "Something went wrong!");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
