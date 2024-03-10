import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
 final void Function()? onTap; 
  const SocialLoginButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
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
            const SizedBox(
              width: 15,
            ),
            const Expanded(
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
