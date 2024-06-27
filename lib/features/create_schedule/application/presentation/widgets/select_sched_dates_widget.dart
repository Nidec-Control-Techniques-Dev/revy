// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../.././../bloc/create_schedule_bloc.dart';

// class DatePickerWidget extends StatefulWidget {
//   const DatePickerWidget({super.key});
  
//   @override
//   _DatePickerWidgetState createState() => _DatePickerWidgetState();
// }

// class _DatePickerWidgetState extends State<DatePickerWidget> {
//   DateTime? _selectedDate1;
//   DateTime? _selectedDate2;

//   Future<DateTime?> _selectDate(BuildContext context, int dateNumber) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 30)),
//     );
//     if (picked != null && picked != (dateNumber == 1 ? _selectedDate1 : _selectedDate2)) {
//       setState(() {
//         if (dateNumber == 1) {
//           _selectedDate1 = picked;
//           context.read<CreateScheduleBloc>().add(DateStageStarted(startDate : picked));
//         } else {
//           _selectedDate2 = picked;
//           context.read<CreateScheduleBloc>().add(DateStageStarted(endDate : picked));
//         }
//       });
//     }
//     return picked;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Text(
//             'Choose your schedule dates',
//             style: TextStyle(fontSize: 22, color: Colors.black),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 40.0),
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () => _selectDate(context, 1),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.zero, // Makes the button square
//                     side: BorderSide(color: Colors.green, width: 2.0), // Green outline
//                   ),
//                 ),
//                 child: const Text('Select Start Date'),
//               ),
//               const SizedBox(width: 10.0), // Add some space between the button and the text
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(8.0),
//                   margin: const EdgeInsets.symmetric(vertical: 10.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 2.0), // Green outline
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     _selectedDate1 == null
//                         ? 'No date selected for Date 1'
//                         : 'Selected Start Date: ${formatter.format(_selectedDate1!.toLocal())}',
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold, // Make the text bold
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 40.0),
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () => _selectDate(context, 2),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.zero, // Makes the button square
//                     side: BorderSide(color: Colors.green, width: 2.0), // Green outline
//                   ),
//                 ),
//                 child: const Text('Select End Date'),
//               ),
//               const SizedBox(width: 10.0), // Add some space between the button and the text
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(8.0),
//                   margin: const EdgeInsets.symmetric(vertical: 10.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black, width: 2.0), // Green outline
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     _selectedDate2 == null
//                         ? 'No date selected for Date 2'
//                         : 'Selected End Date: ${formatter.format(_selectedDate2!.toLocal())}',
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold, // Make the text bold
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../.././../bloc/create_schedule_bloc.dart';

// class DatePickerWidget extends StatefulWidget {
//   const DatePickerWidget({super.key});
  
//   @override
//   _DatePickerWidgetState createState() => _DatePickerWidgetState();
// }

// class _DatePickerWidgetState extends State<DatePickerWidget> {
//   DateTime? _selectedDate1;
//   DateTime? _selectedDate2;

//   Future<DateTime?> _selectDate(BuildContext context, int dateNumber) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 30)),
//     );
//     if (picked != null && picked != (dateNumber == 1 ? _selectedDate1 : _selectedDate2)) {
//       setState(() {
//         if (dateNumber == 1) {
//           _selectedDate1 = picked;
//           context.read<CreateScheduleBloc>().add(DateStageStarted(startDate : picked));
//         } else {
//           _selectedDate2 = picked;
//           context.read<CreateScheduleBloc>().add(DateStageStarted(endDate : picked));
//         }
//       });
//     }
//     return picked;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Text(
//             'Choose your schedule dates',
//             style: TextStyle(fontSize: 22, color: Colors.black),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 40.0),
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () => _selectDate(context, 1),
//                   style: ElevatedButton.styleFrom(
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.zero,
//                     side: BorderSide(color: Colors.green, width: 2.0), 
//                   ),
//                 ),
//                 child: const Text('Select Start Date'),
//               ),
//               const SizedBox(width: 10.0), // Add some space between the button and the text
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(8.0),
//                   margin: const EdgeInsets.symmetric(vertical: 10.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     _selectedDate1 == null
//                         ? 'No date selected for Date 1'
//                         : 'Selected Start Date: ${formatter.format(_selectedDate1!.toLocal())}',
//                     style: const TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 40.0),
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () => _selectDate(context, 2),
//                   style: ElevatedButton.styleFrom(
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.zero,
//                   side: BorderSide(color: Colors.green, width: 2.0), 
//                   ),
//                 ),
//                 child: const Text('Select End Date'),
//               ),
//               const SizedBox(width: 10.0), // Add some space between the button and the text
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(8.0),
//                   margin: const EdgeInsets.symmetric(vertical: 10.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     _selectedDate2 == null
//                         ? 'No date selected for Date 2'
//                         : 'Selected End Date: ${formatter.format(_selectedDate2!.toLocal())}',
//                     style: const TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 200.0),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../.././../bloc/create_schedule_bloc.dart';

// class DatePickerWidget extends StatefulWidget {
//   const DatePickerWidget({super.key});
  
//   @override
//   _DatePickerWidgetState createState() => _DatePickerWidgetState();
// }

// class _DatePickerWidgetState extends State<DatePickerWidget> {
//   DateTime? _selectedDate1;
//   DateTime? _selectedDate2;

//   Future<DateTime?> _selectDate(BuildContext context, int dateNumber) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 30)),
//     );
//     if (picked != null && picked != (dateNumber == 1 ? _selectedDate1 : _selectedDate2)) {
//       setState(() {
//         if (dateNumber == 1) {
//           _selectedDate1 = picked;
//           context.read<CreateScheduleBloc>().add(DateStageStarted(startDate : picked));
//         } else {
//           _selectedDate2 = picked;
//           context.read<CreateScheduleBloc>().add(DateStageStarted(endDate : picked));
//         }
//       });
//     }
//     return picked;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Text(
//             'Choose your schedule dates',
//             style: TextStyle(fontSize: 22, color: Colors.black),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 40.0),
//           ElevatedButton(
//             onPressed: () => _selectDate(context, 1),
//             child: const Text('Select Start Date'),
//           ),
//           const SizedBox(height: 20.0),
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             margin: const EdgeInsets.symmetric(vertical: 10.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Text(
//               _selectedDate1 == null
//                   ? 'No date selected for Date 1'
//                   : '${formatter.format(_selectedDate1!.toLocal())}',
//               style: const TextStyle(color: Colors.black),
//             ),
//           ),
//           const SizedBox(height: 40.0),
//           ElevatedButton(
//             onPressed: () => _selectDate(context, 2),
//             child: const Text('Select End date'),
//           ),
//           const SizedBox(height: 20.0),
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             margin: const EdgeInsets.symmetric(vertical: 10.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Text(
//               _selectedDate2 == null
//                   ? 'No date selected for Date 2'
//                   : '${formatter.format(_selectedDate2!.toLocal())}',
//               style: const TextStyle(color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../.././../bloc/create_schedule_bloc.dart';

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
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null && picked != (dateNumber == 1 ? _selectedDate1 : _selectedDate2)) {
      setState(() {
        if (dateNumber == 1) {
          _selectedDate1 = picked;
          context.read<CreateScheduleBloc>().add(DateStageStarted(startDate : picked));

        } else {
          _selectedDate2 = picked;
          context.read<CreateScheduleBloc>().add(DateStageStarted(endDate : picked));

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
            child: const Text('Select starting Date'),
          ),
          const SizedBox(height: 20.0),
          Text(
            _selectedDate1 == null
                ? 'No date selected for Date 1'
                : 'Selected Start Date: ${formatter.format(_selectedDate1!.toLocal())}',
                style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () => _selectDate(context, 2),
            child: const Text('Select End date'),
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