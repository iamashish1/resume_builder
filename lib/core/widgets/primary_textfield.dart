import 'package:flutter/material.dart';

class PrimaryTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffix;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool? isObscure;
  final int? maxLines;
  final String? label;
  final void Function(String)? onSubmit;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const PrimaryTextfield(
      {Key? key,
      required this.hintText,
      this.controller,
      this.suffix,
      this.isObscure,
      this.nextFocus,
      this.maxLines,
      this.label,
      this.onChanged,
      this.focusNode,
      this.validator,
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: (label?.isNotEmpty ?? false),
          child: Text(
            "$label",
            style: TextStyle(
                color: const Color.fromARGB(255, 13, 5, 47).withOpacity(1),
                fontWeight: FontWeight.w600),
          ),
        ),
        TextFormField(
          focusNode: focusNode,
          controller: controller,
          obscureText: isObscure ?? false,
          onChanged: onChanged,
          onFieldSubmitted: (v) {
            nextFocus?.requestFocus();
            onSubmit != null ? onSubmit!(v) : ();
          },
          validator: validator ??
              (value) {
                if (value?.isEmpty ?? false) {
                  return 'The field needs some value';
                }
                return null;
              },
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF6F6F6),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xffE8E8E8),
                      width: 1,
                      style: BorderStyle.solid,
                      strokeAlign: 0.1)),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xffE8E8E8),
                      width: 1,
                      style: BorderStyle.solid,
                      strokeAlign: 0.1)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xffE8E8E8),
                      width: 1,
                      style: BorderStyle.solid,
                      strokeAlign: 0.1)),
              border: InputBorder.none,
              suffix: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: suffix,
              ),
              hintText: hintText,
              contentPadding: const EdgeInsets.only(left: 12),
              hintStyle: const TextStyle(color: Color(0xffBDBDBD))),
        ),
      ],
    );
  }
}
