import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_params_bloc.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.white), // Set button background color to white
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide.none,
                        ),
                      ),
                      elevation: WidgetStateProperty.all<double>(5),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                    ),
                    onPressed: pickDateRange,
                    child: Text(
                      '${DateFormat('MMMM dd, yyyy').format(start)} - ${DateFormat('MMMM dd, yyyy').format(end)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      context.read<GetParamsBloc>().add(DatesChanged(
            startDate: dateRange.start,
            endDate: dateRange.end,
          ));
    });
  }
}
// class _DatePickerState extends State<DatePicker> {
//   DateTimeRange dateRange = DateTimeRange(
//     start: DateTime.now(),
//     end: DateTime.now(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     final start = dateRange.start;
//     final end = dateRange.end;

//     return Scaffold(
//         body: Container(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               side: const BorderSide(
//                                   width: 1, color: Colors.black),
//                             ),
//                             backgroundColor:
//                                 const Color.fromARGB(255, 255, 253, 246),
//                             foregroundColor: Colors.black,
//                           ),
//                           onPressed: pickDateRange,
//                           child: Text(
//                             '${start.year}/${start.month}/${start.day} - ${end.year}/${end.month}/${end.day}',
//                             style: GoogleFonts.roboto(
//                                 fontSize: 18, color: Colors.black),
//                           )),
//                     ),
//                   ],
//                 ),
//               ],
//             )));
//   }

//   Future pickDateRange() async {
//     DateTimeRange? newDateRange = await showDateRangePicker(
//         context: context,
//         initialDateRange: dateRange,
//         firstDate: DateTime(1900),
//         lastDate: DateTime(2100));

//     if (newDateRange == null) return;

//     // setState(() => dateRange = newDateRange);
//     setState(() {
//       dateRange = newDateRange;
//       context.read<GetParamsBloc>().add(DatesChanged(
//             startDate: dateRange.start,
//             endDate: dateRange.end,
//           ));
//     });
//   }
// }
