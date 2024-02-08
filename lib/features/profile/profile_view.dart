import 'package:flutter/material.dart';

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
          ElevatedButton(onPressed: () {}, child: Text('Log Out'))
        ],
      ),
    );
  }
}
