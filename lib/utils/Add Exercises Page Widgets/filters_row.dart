import 'package:flutter/material.dart';
import 'package:gym_rat_v2/utils/shared/filters.dart';

class FilterRow extends StatefulWidget {
  const FilterRow({
    super.key,
    required this.label,
    required this.values,
    required this.controller,
  });
  final String label;
  final List<Enum> values;
  final Function controller;
  @override
  State<FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  late String value;
  @override
  void initState() {
    super.initState();
    value = widget.values[0].name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label),
          DropdownButton(
            value: value,
            items: [
              ...widget.values.map(
                (e) => DropdownMenuItem(
                  value: e.name,
                  child: Text(e.getValue),
                ),
              )
            ],
            onChanged: (newVal) {
              setState(() {
                value = newVal!;
                widget.controller(value);
              });
            },
          ),
        ],
      ),
    );
  }
}
