import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/core/theme/custom_theme.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signin_page.dart';
import 'package:resume_builder/features/home/homepage.dart';
import 'package:resume_builder/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//

  final prefs = await SharedPreferences.getInstance();

  final user = prefs.getString("user");

//
  runApp(MyApp(
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  final String? user;
  const MyApp({super.key, this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      home: (user != null) ? const Homepage() : const SigninPage(),
    );
  }
}
