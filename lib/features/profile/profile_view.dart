import 'package:flutter/material.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signin_page.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage:
                NetworkImage("https://www.w3schools.com/howto/img_avatar.png"),
          ),
          Text('Ashish koirala'),
          Text('Iamashishkoirala1@gmail.com'),
          PrimaryButton(
              label: "Logout",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => SigninPage()));
              })
        ],
      ),
    );
  }
}
