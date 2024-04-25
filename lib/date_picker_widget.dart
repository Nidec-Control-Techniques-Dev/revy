import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
 final Function(DateTime) onDateChanged;

 // Using a super parameter for 'key'
 const DatePickerWidget({super.key, required this.onDateChanged});

 Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      onDateChanged(picked);
    }
 }

 @override
 Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _selectDate(context),
      child: const Text('Select Date'),
    );
 }
}
