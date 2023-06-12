import 'package:flutter/material.dart';

class ExercisePropsDropdown extends StatefulWidget {
  const ExercisePropsDropdown({
    super.key,
    required this.label,
    required this.controller,
    required this.values,
    this.trailing,
  });
  final String label;
  final String? trailing;
  final TextEditingController controller;
  final List values;
  @override
  State<ExercisePropsDropdown> createState() => _ExercisePropsDropdownState();
}

class _ExercisePropsDropdownState extends State<ExercisePropsDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownMenu(
        width: MediaQuery.of(context).size.width * 0.5,
        controller: widget.controller,
        label: Text(widget.label),
        trailingIcon: Text(
          /// If there is trailing show it , it there is no trailing then show empty text
          widget.trailing ?? "",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        menuStyle: const MenuStyle(
          maximumSize: MaterialStatePropertyAll(
            Size.fromHeight(150),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        dropdownMenuEntries: [
          ...widget.values.map(
            (e) => DropdownMenuEntry(value: e.toString(), label: e.toString()),
          ),
        ],
      ),
    );
  }
}
