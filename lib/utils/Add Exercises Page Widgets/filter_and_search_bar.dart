import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/utils/Add%20Exercises%20Page%20Widgets/filter_container.dart';

import 'applied_filters_row.dart';

class FilterAndSearchBar extends StatefulWidget {
  const FilterAndSearchBar({super.key});

  @override
  State<FilterAndSearchBar> createState() => _FilterAndSearchBarState();
}

class _FilterAndSearchBarState extends State<FilterAndSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.exerciseProv.searchName.isEmpty
        ? ""
        : context.exerciseProv.searchName;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.85,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    label: Text("Search"),
                  ),
                  onSubmitted: (value) =>
                      context.exerciseProv.searchByName(value),
                ),
              ),
            ),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => const FilterContainer(),
              ),
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ],
        ),
        Visibility(
          visible: context.exerciseProv.filters.isNotEmpty,
          child: const AppliedFiltersRow(),
        )
      ],
    );
  }
}
