import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_params_bloc.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 253, 246),
                            foregroundColor: Colors.black,
                          ),
                          onPressed: pickDateRange,
                          child: Text(
                            '${start.year}/${start.month}/${start.day} - ${end.year}/${end.month}/${end.day}',
                            style: GoogleFonts.roboto(
                                fontSize: 18, color: Colors.black),
                          )),
                    ),
                  ],
                ),
              ],
            )));
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (newDateRange == null) return;

    // setState(() => dateRange = newDateRange);
    setState(() {
      dateRange = newDateRange;
      context.read<GetParamsBloc>().add(DatesChanged(
            startDate: dateRange.start,
            endDate: dateRange.end,
          ));
    });
  }
}
