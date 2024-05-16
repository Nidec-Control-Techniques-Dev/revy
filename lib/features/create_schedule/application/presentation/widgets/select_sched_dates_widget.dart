import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (dateNumber == 1 ? _selectedDate1 : _selectedDate2)) {
      setState(() {
        if (dateNumber == 1) {
          _selectedDate1 = picked;
        } else {
          _selectedDate2 = picked;
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
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () => _selectDate(context, 1),
            child: const Text('Selected starting Date'),
          ),
          const SizedBox(height: 20.0),
          Text(
            _selectedDate1 == null
                ? 'No date selected for Date 1'
                : 'Selected Start Date: ${formatter.format(_selectedDate1!.toLocal())}',
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () => _selectDate(context, 2),
            child: const Text('Selected end date'),
          ),
          const SizedBox(height: 20.0),
          Text(
            _selectedDate2 == null
                ? 'No date selected for Date 2'
                : 'Selected End Date: ${formatter.format(_selectedDate2!.toLocal())}',
          ),
          

        ],
      ),
    );
  }
}