import 'package:flutter/material.dart';
import 'package:gym_rat_v2/Theme/theme_manager.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.pickDate, required this.validator,
  });

  final Function pickDate;
  final Function validator;
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final TextEditingController _controller = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  Future<void> _setDate(BuildContext context) async {
    final DateTime? _pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: themeMode == ThemeMode.light
                ? ColorScheme.light(
                    // Header Color
                    primary: Theme.of(context).primaryColor,
                    // Header Text Color
                    onPrimary: Theme.of(context).textTheme.bodySmall!.color!,
                    // Body Text Color
                    onSurface: Theme.of(context).textTheme.bodySmall!.color!,
                  )
                : const ColorScheme.dark(),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 1),
      lastDate: DateTime.now(),
    );

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
      child: TextFormField(
        validator: (String? val) => widget.validator(val),
        decoration: InputDecoration(
            labelText: "Pick Birthdate",
            border: _border,
            enabledBorder: _border,
            focusedBorder: _border,
            labelStyle: const TextStyle(color: AppColors.kTextColor),
            floatingLabelStyle: Theme.of(context).textTheme.bodySmall),
        readOnly: true,
        controller: _controller,
        onTap: () => _setDate(context),
      ),
    );
  }
}
