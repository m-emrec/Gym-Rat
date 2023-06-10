import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/models/workout_model.dart';
import 'package:gym_rat_v2/provider/workout_provider.dart';
import 'package:gym_rat_v2/utils/shared/circle_button.dart';
import 'package:gym_rat_v2/utils/shared/custom_text_field.dart';
import 'package:gym_rat_v2/utils/shared/form_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../constants.dart';

class AddNewWorkoutPage extends StatefulWidget {
  static const routeName = "add-new-workout-page";

  const AddNewWorkoutPage({super.key});

  @override
  State<AddNewWorkoutPage> createState() => _AddNewWorkoutPageState();
}

class _AddNewWorkoutPageState extends State<AddNewWorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _fomrFieldIndex = 0;

  String? _validatorFunc(String? val) {
    if (val!.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  CustomTextFormField _formField(ValueKey key) {
    return CustomTextFormField(
      key: key,
      textController: TextEditingController(),
      label: "Workout Name",
      validator: _validatorFunc,
      startWithCapital: true,
      suffixWidget: SizedBox(
        height: 16,
        width: 32,
        child: CloseButton(
          onPressed: () => setState(
            () {
              _formFields.removeWhere((element) => element.key == key);
            },
          ),
        ),
      ),
    );
  }

  final List<CustomTextFormField> _formFields = [];

  /// This function collects the data from the @[_formFields] list and returns it as a List of @[WorkoutModel].
  List<WorkoutModel> _collectData(List<CustomTextFormField> workoutData) {
    final List<WorkoutModel> dataList = [];

    for (var data in workoutData) {
      dataList.add(
        WorkoutModel(
          name: data.textController.text,
          id: const Uuid().v4(),
        ),
      );
    }
    logger.d(dataList.length);

    return dataList;
  }

  @override
  void initState() {
    super.initState();
    _formFields.add(
      _formField(
        ValueKey(_fomrFieldIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String cycleId =
        ModalRoute.of(context)!.settings.arguments.toString();
    logger.i(cycleId);
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          style: const ButtonStyle().copyWith(
            foregroundColor: MaterialStatePropertyAll(
              Colors.red.shade800,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Back"),
        ),
        title: Text(
          "Add Workout",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 16,
                color: AppColors.kButtonColor,
              ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Consumer<WorkoutProvider>(
        builder: (context, value, child) => CircleButton(
          label: "Done",
          onTap: () => value
              .addWorkoutToDatabase(
                cycleID: cycleId,
                data: _collectData(_formFields),
              )
              .then(
                (_) => Navigator.of(context).pushReplacementNamed("/"),
              ),
          icon: Icons.done,
          radius: 32,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Form Field
            FormWidget(
              formKey: _formKey,
              children: [
                ..._formFields,
              ],
            ),
            // Add Workout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OutlinedButton(
                onPressed: () {
                  // if the formfield is not empty then add new formfield.
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _fomrFieldIndex++;
                      _formFields.add(
                        _formField(ValueKey(_fomrFieldIndex)),
                      );
                    });
                  }
                },
                style: const ButtonStyle().copyWith(
                  fixedSize: const MaterialStatePropertyAll(
                    Size.fromWidth(double.maxFinite),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    8.pw(),
                    const Text("Add Workout"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
