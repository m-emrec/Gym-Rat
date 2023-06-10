import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';
import 'package:gym_rat_v2/models/cycle_model.dart';
import 'package:gym_rat_v2/provider/cycle_provider.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/add_new_workout_screen.dart';
import 'package:gym_rat_v2/utils/Start%20New%20Cycle%20Page%20Widgets/cycle_week_container.dart';
import 'package:gym_rat_v2/utils/shared/circle_button.dart';
import 'package:gym_rat_v2/utils/shared/custom_text_field.dart';
import 'package:gym_rat_v2/utils/shared/form_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../logger.dart';

class StartNewCyclePage extends StatelessWidget {
  static const routeName = "start-new-cycle-page";

  StartNewCyclePage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cycleNameController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();

  int _cycleWeek = 4;

  void _cycleWeekController(int week) {
    _cycleWeek = week;
    logger.i(_cycleWeek);
  }

  Future<void> _getCycleData(func, CycleModel cycleData) async {
    logger.i(cycleData.printData());
    await func(cycleData);
  }

  String? _validatorFunc(String? val) {
    if (val!.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: TextButton(
          style: const ButtonStyle().copyWith(
            foregroundColor: MaterialStatePropertyAll(
              AppColors.kRedCollor,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        title: Text(
          "Start New Cycle",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 16, color: AppColors.kButtonColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.8,
              child: FormWidget(
                formKey: _formKey,
                children: [
                  (size.height * 0.1).ph(),
                  // Cycle Name
                  CustomTextFormField(
                    textController: _cycleNameController,
                    label: "Cycle Name",
                    goToNextTextField: true,
                    startWithCapital: true,
                    validator: _validatorFunc,
                  ),
                  (size.height * 0.1).ph(),
                  CycleWeek(
                    controllerFunction: _cycleWeekController,
                  ),
                  (size.height * 0.1).ph(),

                  // Goal
                  CustomTextFormField(
                    textController: _goalController,
                    label: "Your Goal at the End of This Cycle",
                    startWithCapital: true,
                    validator: _validatorFunc,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Consumer<CycleProvider>(
                  builder: (context, value, child) => CircleButton(
                      label: "Next",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final String id = Uuid().v4();
                          _getCycleData(
                            value.createNewCycle,
                            CycleModel(
                              cycleName: _cycleNameController.text,
                              id: id,
                              startDate: DateTime.now(),
                              isActive: true,
                              numberOfWeeks: _cycleWeek,
                              goal: _goalController.text,
                            ),
                          ).then(
                            (value) => Navigator.of(context).pushNamed(
                              AddNewWorkoutPage.routeName,
                              arguments: id,
                            ),
                          );
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
