import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:resume_builder/core/theme/custom_theme.dart';
import 'package:resume_builder/features/authentication/data/data_source/remote_data_source.dart';
import 'package:resume_builder/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:resume_builder/features/authentication/domain/usecases/sign_in_cubit.dart';
import 'package:resume_builder/features/authentication/presentation/bloc/cubit/sign_in_cubit.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signin_page.dart';
import 'package:resume_builder/features/home/homepage.dart';
import 'package:resume_builder/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    unawaited(MobileAds.instance.initialize());
  // Load environment variables from .env file
  await dotenv.load();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final user = prefs.getString("user");
  runApp(BlocProvider<SignInCubit>(
    create: (context) => SignInCubit(SignIn(AuthenticationRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl()))),
    child: MyApp(
      user: user,
    ),
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
