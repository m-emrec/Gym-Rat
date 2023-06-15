import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';

class AppliedFiltersRow extends StatefulWidget {
  const AppliedFiltersRow({
    super.key,
  });

  @override
  State<AppliedFiltersRow> createState() => _AppliedFiltersRowState();
}

class _AppliedFiltersRowState extends State<AppliedFiltersRow> {
  @override
  Widget build(BuildContext context) {
    List filterList = context.exerciseProv.filters.keys.toList();
    Map filters = context.exerciseProv.filters;
    return Row(
      children: [
        ...(filterList.map(
          (e) => filters[e] == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Chip(
                    label: Text(filters[e]),
                    onDeleted: () {
                      setState(() {
                        context.exerciseProv.filters.remove(e);
                        context.exerciseProv
                            .setFilters(context.exerciseProv.filters);
                      });
                    },
                  ),
                ),
        ))
      ],
    );
  }
}
