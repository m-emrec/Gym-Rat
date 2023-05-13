import 'package:flutter/material.dart';

class GenderDropdownButton extends StatefulWidget {
  GenderDropdownButton({
    super.key,
    required this.controller,
    required this.changeGender,
  });

  final Function changeGender;

  String? controller;

  @override
  State<GenderDropdownButton> createState() => _GenderDropdownButtonState();
}

class _GenderDropdownButtonState extends State<GenderDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(15),
      isExpanded: true,
      value: widget.controller,
      onChanged: (value) {
        setState(
          () {
            widget.controller = value;
            widget.changeGender(value);
          },
        );
      },
      items: const [
        DropdownMenuItem(
          value: "male",
          child: Text("Male"),
        ),
        DropdownMenuItem(
          value: "female",
          child: Text("Female"),
        )
      ],
    );
  }
}
