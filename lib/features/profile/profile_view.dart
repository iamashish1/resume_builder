import 'package:flutter/material.dart';
import 'package:resume_builder/core/widgets/primary_button.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signin_page.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: SingleChildScrollView(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 4,
                backgroundImage: NetworkImage(
                    "https://www.w3schools.com/howto/img_avatar.png"),
              ),
              Text(
                'Ashish koirala',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'Iamashishkoirala1@gmail.com',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              ),
            ],
          ),
        )),
        Padding(
          padding: EdgeInsets.all(18),
          child: PrimaryButton(
              label: "Logout",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => SigninPage()));
              }),
        ),
      ],
    );
  }
}
