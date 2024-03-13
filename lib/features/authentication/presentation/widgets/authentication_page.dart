import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';
import 'package:resume_builder/core/constants/app_constants.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/core/widgets/social_login_button.dart';
import 'package:resume_builder/features/authentication/data/model/login_request_model.dart';
import 'package:resume_builder/features/authentication/presentation/bloc/cubit/sign_in_cubit.dart';
import 'package:resume_builder/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signin_page.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signup_page.dart';
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
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (error) {
            Fluttertoast.showToast(msg: error);
          },
        );
      },
      builder: (context, state) {
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
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.primaryGreen),
                      )),
                ),
              ],
              title: Text(
                isSignInpage ? 'Login' : 'Sign up',
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              )),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  PrimaryTextfield(
                      validator: (v) {
                        if (emailRegex.hasMatch(v ?? "")) {
                          return null;
                        } else {
                          return ('Enter valid email');
                        }
                      },
                      controller: email,
                      hintText: 'Email',
                      focusNode: emailFocus,
                      nextFocus: passwordFocus),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryTextfield(
                    validator: (v) {
                      if ((v?.length ?? 0) > 4) {
                        return null;
                      } else {
                        return ('Password must at least be 5 characters');
                      }
                    },
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
                      child: const Text(
                        "Show",
                        style: TextStyle(
                            color: Color(0xff5DB075),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<SignInCubit, SignInState>(
                      builder: (btnCtx, btnState) {
                    return PrimaryButton(
                      isLoading: (btnState.maybeWhen(
                          loading: () => true, orElse: () => false)),
                      label: isSignInpage ? 'Login' : 'Signup',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignInCubit>().signInUser(
                              LoginRequestModel(
                                  isSignUp: !isSignInpage,
                                  email: email.text.trim(),
                                  password: password.text.trim()));
                        }
                      },
                    );
                  }),
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
                  const SizedBox(
                    height: 20,
                  ),
                  // Text('Not a member?'),
                  const Text(
                    'Or use google login:',
                    style: TextStyle(color: Color.fromARGB(255, 122, 120, 120)),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  SocialLoginButton(
                    onTap: () async {
                      try {
                        final user = await signInWithGoogle();
                        //SAVE TO SAHREDPREFS

                        final pref = await SharedPreferences.getInstance();

                        pref.setString("user", user.toString());
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
      },
    );
  }
}
