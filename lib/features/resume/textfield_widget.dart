import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLines;
  final String label;
  final String? hintText;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  const TextfieldWidget({
    Key? key,
     this.controller,
    this.maxLines,
    this.hintText,
    this.focusNode,
    this.onChanged,
    required this.label,
  })  : assert(maxLines == null || maxLines > 0,
            'maxLines must be null or greater than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
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
