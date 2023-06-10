import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.formKey,
    required this.children,
    this.title,
  });

  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              title == null
                  ? const SizedBox()
                  : Text(
                      title!,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16),
                    ),
              ...children
            ],
          ),
        ),
      ),
    );
  }
}
