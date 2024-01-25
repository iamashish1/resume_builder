import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String label;
  final String? hintText;
  final FocusNode? focusNode;
  const TextfieldWidget({
    Key? key,
    required this.controller,
    this.maxLines,
    this.hintText,
    this.focusNode,
    required this.label,
  })  : assert(maxLines == null || maxLines > 0,
            'maxLines must be null or greater than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      focusNode: focusNode,
      decoration: InputDecoration(
          isDense: true,
          border: const OutlineInputBorder(),
          label: Text(
            label,
          ),
          alignLabelWithHint: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
