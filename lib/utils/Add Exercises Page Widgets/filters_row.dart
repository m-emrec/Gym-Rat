import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/utils/shared/filters.dart';

class FilterRow extends StatefulWidget {
  const FilterRow({
    super.key,
    required this.label,
    required this.values,
    required this.controller,
    required this.filterType,
  });
  final String label;
  final List<Enum> values;
  final Function controller;
  final String filterType;
  @override
  State<FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  late String value;
  @override
  void initState() {
    super.initState();
    value = context.exerciseProv.filters[widget.filterType] ??
        widget.values[0].name;
    widget.controller(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// label
          Text(
            widget.label,
            style: context.textTheme.labelLarge,
          ),
          SizedBox(
            width: context.mediaQuerySize.width * 0.36,
            child: DropdownButton(
              style: context.textTheme.labelSmall,
              value: value,
              items: [
                ...widget.values.map(
                  (e) => DropdownMenuItem(
                    value: e.name,
                    child: SizedBox(
                      width: context.mediaQuerySize.width * 0.3,
                      child: Text(
                        e.getValue,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
          ),
        ],
      ),
    );
  }
}
