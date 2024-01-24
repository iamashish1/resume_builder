import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signup_page.dart';
import 'package:resume_builder/features/home/homepage.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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
                'Welcome back!'),
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
            ElevatedButton(onPressed: () async {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()));

            }, child: Text('Sign in')),
            Text('Not a member?'),
            TextButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupPage()));
            }, child: Text('Sign up')),
            Text('OR'),
            ElevatedButton.icon(
                icon: Image.asset(
                  'assets/google_icon.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () async {
                  final result = await signInWithGoogle();
                  print(result);
                },
                label: Text('Continue with google'))
          ],
        ),
      ),
    );
  }
}