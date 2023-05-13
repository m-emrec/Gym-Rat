import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/models/user_model.dart';
import 'package:gym_rat_v2/screens/auth_page.dart';
import 'package:gym_rat_v2/screens/workouts_main_page_screen.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/custom_buton.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/custom_progress_indicator.dart';
import 'package:gym_rat_v2/utils/Forms/get_started_page_form.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class GetStartedPage extends StatelessWidget {
  GetStartedPage({super.key});

  static const routeName = "get-started-page";

  final TextEditingController nameController = TextEditingController();
  String genderController = "male";
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  void changeGender(String gender) {
    genderController = gender;
  }

  void pickDate(DateTime pickDate) {
    selectedDate = pickDate;
  }

  Map<String, dynamic> get collectedData {
    return {
      "name": nameController.text,
      "gender": genderController,
      "length": double.parse(lengthController.text),
      "weight": double.parse(weightController.text),
      "birthdate": selectedDate
    };
  }

  void saveDataToDatabase(
      BuildContext context, Map<String, dynamic> data) async {
    final userData = UserModel(
      userName: data["name"],
      uid: FirebaseAuth.instance.currentUser?.uid,
      gender: data["gender"],
      birthDate: data["birthdate"],
      length: data["length"],
      weight: data["weight"],
    );

    CustomProgressIndicator().showProgressIndicator(context);
    logger.i(userData);
    await Provider.of<UserProvider>(context, listen: false)
        .addUserToDatabase(userData);

    Navigator.of(context).pushReplacementNamed("/").then(
          (value) => Navigator.pop(
            context,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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

              ///Text fields
              GetStartedForm(
                formKey: _formKey,
                nameController: nameController,
                lengthController: lengthController,
                weightController: weightController,
                changeGender: changeGender,
                genderController: genderController,
                pickDate: pickDate,
              ),

              CustomButton(
                text: "Continue",
                onTap: () => _formKey.currentState!.validate()
                    ? saveDataToDatabase(context, collectedData)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
