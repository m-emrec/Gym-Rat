import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/models/user_model.dart';
import 'package:gym_rat_v2/provider/user_provider.dart';
import 'package:gym_rat_v2/screens/workouts_main_page_screen.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/customTitle.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/custom_buton.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/custom_text_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GetStartedPage extends StatelessWidget {
  GetStartedPage({super.key});

  static const routeName = "get-started-page";

  final TextEditingController nameController = TextEditingController();
  String genderController = "male";
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void changeGender(String gender) {
    genderController = gender;
  }

  void pickDate(DateTime pickDate) {
    selectedDate = pickDate;
  }

  Map<String,dynamic> get collectedData {
    return {
      "name": nameController.text,
      "gender": genderController,
      "length": double.parse(lengthController.text),
      "weight": double.parse(weightController.text),
      "birthdate": selectedDate
    };
  }

  void saveDataToDatabase(BuildContext context, Map<String,dynamic> data) {
    final userData = UserModel(
        userName: data["name"],
        uid: FirebaseAuth.instance.currentUser?.uid,
        gender: data["gender"],
        birthDate: data["birthdate"],
        length: data["length"],
        weight: data["weight"]);
    Provider.of<UserProvider>(context, listen: false)
        .addUserToDatabase(userData);

      Navigator.of(context).pushReplacementNamed(WorkoutsMainPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hello Text
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Text(
                "Hello Gym Rat",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            // Let us know you text
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Let us know about you.",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.kButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ElevatedButton(onPressed: ()=> FirebaseAuth.instance.signOut(), child: Text("Cıkıs")),
            CustomTextFormField(textController: nameController, label: "Name",validator: (){},),
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
            ),
            CustomTextFormField(
              textController: lengthController,
              label: "Length",
              goToNextTextField: true,
              validator: (){},
              
            ),
            CustomTextFormField(
              textController: weightController,
              label: "Weight",
              validator: (){},
            ),
            CustomButton(
              text: "Continue",
              onTap: () => saveDataToDatabase(context, collectedData),
            ),
          ],
        ),
      ),
    );
  }
}

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
        setState(() {
          widget.controller = value;
          widget.changeGender(value);
        });
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

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.pickDate});

  final Function pickDate;
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final TextEditingController _controller = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  Future<void> _setDate(BuildContext context) async {
    final DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950, 1),
        lastDate: DateTime.now());

    if (_pickedDate != null && _pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = _pickedDate;
        _controller.text = DateFormat.yMMMMd().format(_selectedDate);
        widget.pickDate(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder _border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(5),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Pick Birthdate",
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          labelStyle: const TextStyle(color: AppColors.kTextColor),
          floatingLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.kTextColor),
        ),
        readOnly: true,
        controller: _controller,
        onTap: () => _setDate(context),
      ),
    );
  }
}
