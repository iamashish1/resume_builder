import 'package:flutter/material.dart';

class SkillsSection extends StatefulWidget {
  final String skill;
  final int index;
  final void Function()? onAddPressed;
  final void Function(String, int)? onChnaged;
  final void Function(int)? onSkillDeleted;
  const SkillsSection(
      {super.key,
      required this.skill,
      this.onAddPressed,
      this.onChnaged,
      this.onSkillDeleted, required this.index});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  @override
  Widget build(BuildContext context) {
    return  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          IconButton(
            onPressed: null,
            icon: Text("${widget.index + 1}"),
          ),
          Expanded(
            child: TextFormField(
                controller: TextEditingController(text: widget.skill),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                maxLines: null,
                onChanged: (value) {
                  widget.onChnaged?.call(value, widget.index);
                },
                decoration: const InputDecoration(
                  hintText: 'Mention a skill',
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                )),
          ),
          IconButton(
            onPressed: () {
              widget.onSkillDeleted?.call(widget.index);
            },
            icon: const Icon(
              Icons.delete,
            ),
            splashColor: Colors.green,
            iconSize: 15,
            color: Colors.grey,
          ),
        ]);
  }
}
