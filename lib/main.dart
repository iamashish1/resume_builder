import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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
// Import the firebase_app_check plugin
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  // Load environment variables from .env file
  await dotenv.load();
//Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  //GET FROM SHAREDPREFS
  final prefs = await SharedPreferences.getInstance();
  final savedUser = prefs.getString("user");

  runApp(StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        UserStatus status =
            (snapshot.connectionState == ConnectionState.waiting)
                ? UserStatus.loading
                : ((snapshot.hasData && snapshot.data != null) ||
                        (savedUser != null && savedUser != ""))
                    ? UserStatus.auth
                    : UserStatus.unauth;
        return BlocProvider<SignInCubit>(
          create: (context) => SignInCubit(SignIn(AuthenticationRepositoryImpl(
              remoteDataSource: RemoteDataSourceImpl()))),
          child: MyApp(
            user: status,
          ),
        );
      }));
}

class MyApp extends StatelessWidget {
  final UserStatus user;
  const MyApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        key: UniqueKey(),
        title: '',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        home: Builder(builder: (context) {
          if (user == UserStatus.loading) {
            return const CircularProgressIndicator();
          } else if (user == UserStatus.auth) {
            return const Homepage();
          } else if (user == UserStatus.unauth) {
            return const SigninPage();
          } else {
            return const Placeholder();
          }
        }));
  }
}

enum UserStatus { auth, unauth, loading }
