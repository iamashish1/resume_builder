import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/core/theme/custom_theme.dart';
import 'package:resume_builder/features/home/homepage.dart';
import 'package:resume_builder/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      home: const Homepage(),
    );
  }
}
