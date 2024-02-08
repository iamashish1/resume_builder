import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // final result = await signInWithGoogle();
      },
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.blue,
            border: Border.all(color: Colors.blue, width: 2)),
        child: Row(
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                'assets/google_icon.png',
                width: 35,
                height: 35,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                'Continue with google',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
