import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 4,
                backgroundImage: CachedNetworkImageProvider(
                  FirebaseAuth.instance.currentUser?.photoURL ?? "",
                  errorListener: (_) {
                  },
                ),
              ),
              Text(
                FirebaseAuth.instance.currentUser?.displayName ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                FirebaseAuth.instance.currentUser?.email ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              ),
            ],
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(18),
          child: PrimaryButton(
              isLoading: false,
              label: "Logout",
              onPressed: () async {
                try {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final GoogleSignIn googleSignIn = GoogleSignIn();

                  await auth.signOut();
                  await googleSignIn.signOut();

                  final prefs = await SharedPreferences.getInstance();
                  //clears everything in sharedprefs
                  await prefs.clear();
                } catch (_) {
                  Fluttertoast.showToast(msg: 'Error Signing out');
                }
              }),
        ),
      ],
    );
  }
}
