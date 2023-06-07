import 'package:flutter/material.dart';

import '../shared/custom_text_field.dart';
import '../Get Starter Page Widgets/date_picker.dart';
import '../Get Starter Page Widgets/gender_dropdown.dart';

class GetStartedForm extends StatelessWidget {
  const GetStartedForm({
    super.key,
    required this.nameController,
    required this.lengthController,
    required this.weightController,
    required this.formKey,
    required this.genderController,
    required this.changeGender,
    required this.pickDate,
  });
  final TextEditingController nameController;
  final TextEditingController lengthController;
  final TextEditingController weightController;

  final String genderController;
  final Function changeGender;
  final Function pickDate;

  final GlobalKey<FormState> formKey;
  String? validator(String? val) {
    if (val!.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            textController: nameController,
            label: "Name",
            validator: validator,
            goToNextTextField: true,
            startWithCapital: true,
          ),
          CustomTextFormField(
            textController: lengthController,
            label: "Length",
            goToNextTextField: true,
            validator: validator,
            keyboardType: TextInputType.number,
            suffixText: "cm",
          ),
          CustomTextFormField(
            textController: weightController,
            label: "Weight",
            validator: validator,
            keyboardType: TextInputType.number,
            suffixText: "kg",
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: GenderDropdownButton(
              controller: genderController,
              changeGender: changeGender,
            ),
          ),
          DatePicker(
            pickDate: pickDate,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
