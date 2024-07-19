import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/create_schedule_bloc.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});
  
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate1;
  DateTime? _selectedDate2;

  Future<DateTime?> _selectDate(BuildContext context, int dateNumber) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      setState(() {
        if (dateNumber == 1) {
          _selectedDate1 = picked;
          context.read<CreateScheduleBloc>().add(DateStageStarted(startDate: picked));
        } else {
          if (_selectedDate1 != null && picked.isBefore(_selectedDate1!)) {
            // Show an error message if the end date is before the start date
            _selectedDate2 = _selectedDate1;
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('End date must be after the start date.'),
            //     backgroundColor: Colors.red,
            //   ),
            // );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Invalid Date Selection'),
                  content: const Text('End date must be after the start date.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            _selectedDate2 = picked;
            context.read<CreateScheduleBloc>().add(DateStageStarted(endDate: picked));
          }
        }
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Choose your schedule dates',
            style: TextStyle(fontSize: 22, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () => _selectDate(context, 1),
            child: const Text('Select Start Date'),
          ),
          const SizedBox(height: 20.0),
          Text(
            _selectedDate1 == null
                ? 'No date selected for Date 1'
                : 'Selected Start Date: ${formatter.format(_selectedDate1!.toLocal())}',
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () => _selectDate(context, 2),
            child: const Text('Select End Date'),
          ),
          const SizedBox(height: 20.0),
          Text(
            _selectedDate2 == null
                ? 'No date selected for Date 2'
                : 'Selected End Date: ${formatter.format(_selectedDate2!.toLocal())}',
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
