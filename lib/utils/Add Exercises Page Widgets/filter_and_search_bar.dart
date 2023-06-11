import 'package:flutter/material.dart';
import 'package:gym_rat_v2/utils/Add%20Exercises%20Page%20Widgets/filter_container.dart';

import '../shared/custom_text_field.dart';

class FilterAndSearchBar extends StatelessWidget {
  FilterAndSearchBar({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width * 0.88,
          height: 120,
          child: CustomTextFormField(
            textController: _controller,
            label: "Search",
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
    );
  }
}
