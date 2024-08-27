// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import '../../bloc/get_params_bloc.dart';

// class DatePicker extends StatefulWidget {
//   const DatePicker({super.key});

//   @override
//   _DatePickerState createState() => _DatePickerState();
// }

// class _DatePickerState extends State<DatePicker> {
//   DateTimeRange dateRange = DateTimeRange(
//     start: DateTime.now(),
//     end: DateTime.now(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     final start = dateRange.start;
//     final end = dateRange.end;

//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             const Align(
//               alignment: Alignment.topLeft,
//               child: Text(
//                 'Select your preferred start and end date',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                       shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
//                       elevation: MaterialStateProperty.all<double>(5),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           side: const BorderSide(color: Colors.green, width: 2),
//                         ),
//                       ),
//                       padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                         const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                       ),
//                     ),
//                     onPressed: () => pickDateRange(context, start, end),
//                     child: Text(
//                       '${DateFormat('MMMM dd, yyyy').format(start)} - ${DateFormat('MMMM dd, yyyy').format(end)}',
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> pickDateRange(BuildContext context, DateTime start, DateTime end) async {
//     DateTimeRange? newDateRange = await showDateRangePicker(
//       context: context,
//       initialDateRange: DateTimeRange(start: start, end: end),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );

//     if (newDateRange == null) return;

//     setState(() {
//       dateRange = newDateRange;
//       context.read<GetParamsBloc>().add(DatesChanged(
//             startDate: dateRange.start,
//             endDate: dateRange.end,
//           ));
//     });
//   }
// }


import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/get_params_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

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

    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the start
          children: [
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.topLeft, // Align text to the top-left
              child: Text(
                'Select start and end schedule date',
                style:  TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Space out the elements
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shadowColor: WidgetStateProperty.all<Color>(
                          Colors.grey), // Add shadow color
                      elevation: WidgetStateProperty.all<double>(5),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color: Colors.green, width: 2), // Green border
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                    ),
                    onPressed: () => pickDateRange(context, start, end),
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
      );
  }

  Future<void> pickDateRange(
      BuildContext context, DateTime start, DateTime end) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: start, end: end),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      // Assuming GetParamsBloc is available in this scope
      context.read<GetParamsBloc>().add(DatesChanged(
            startDate: dateRange.start,
            endDate: dateRange.end,
          ));
    });
  }
}
