import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/core/widgets/primary_textfield.dart';
import 'package:resume_builder/core/widgets/social_login_button.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signup_page.dart';
import 'package:resume_builder/features/authentication/presentation/widgets/authentication_page.dart';
import 'package:resume_builder/features/home/homepage.dart';

import '../../../../core/theme/app_colors.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // final email = TextEditingController();
  // final password = TextEditingController();
  // final emailFocus = FocusNode();
  // final passwordFocus = FocusNode();

  // Future<void> addUserToFirestore(User? user) async {
  //   // Reference to Firestore collection
  //   final usersCollection = FirebaseFirestore.instance.collection('users');

  //   // Create user document in Firestore
  //   await usersCollection.doc(user?.uid).set({
  //     'uid': user?.uid,
  //     'name': user?.displayName,
  //     'email': user?.email,
  //     'profile_picture': user?.photoURL,
  //   });
  // }

  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     final userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     // Add user data to Firestore
  //     await addUserToFirestore(userCredential.user);

  //     return userCredential;
  //   } on FirebaseAuthException catch (firebaseException) {
  //     throw (AppException(
  //         code: firebaseException.code, message: firebaseException.message));
  //   } catch (error) {
  //     throw (AppException(code: 'NO_ERR_CODE', message: 'UNKNOWN EXCEPTION'));
  //   }
  // }

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return const AuthenticationPage(
      isSignIn: true,
    );
  }
}
