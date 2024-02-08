import 'package:flutter/material.dart';
import 'package:resume_builder/core/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final double? width;
  const PrimaryButton(
      {super.key, required this.label, this.width, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryGreen,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          width: width,
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
