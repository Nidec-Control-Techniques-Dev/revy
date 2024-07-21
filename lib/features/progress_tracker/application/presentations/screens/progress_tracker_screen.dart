import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revy/features/progress_tracker/application/presentations/widgets/button_apply.dart';
import 'package:revy/features/progress_tracker/bloc/get_params_bloc.dart';
import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
import '../widgets/client_list.dart';
import '../widgets/date_picker.dart';
import '../widgets/progress_bar.dart';
import '../widgets/filter_status.dart';

class ProgressTrackerApp extends StatelessWidget {
  const ProgressTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetParamsBloc>(
          create: (context) => GetParamsBloc(),
        ),
        BlocProvider<ReadProgressBloc>(
          create: (context) => ReadProgressBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Progress Tracker',
            style: TextStyle(
              fontFamily: 'ArchivoBlack',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: const ProgressTrackerChild(),
      ),
    );
  }
}

class ProgressTrackerChild extends StatelessWidget {
  const ProgressTrackerChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const Text(
        //   'Progress Tracker',
        //   style: TextStyle(
        //       fontSize: 40,
        //       fontWeight: FontWeight.bold,
        //       fontFamily: 'ArchivoBlack'),
        //   textAlign: TextAlign.center,
        // ),
        Expanded(
          // Wrap your SingleChildScrollView with an Expanded widget to allow it to take up remaining space
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   height: 200,
                //   alignment: Alignment.center,
                //   child: const ProgressBar(),
                // ),
                Container(
                  height: 100, // Half of the original height
                  alignment: Alignment.center,
                  child: const FilterStatus(),
                ),
                Container(
                  height: 220, // Half of the original height
                  alignment: Alignment.center,
                  child: const DatePicker(),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const ButtonApply(),
                ),
                Container(
                  height: 400.0,
                  alignment: Alignment.center,
                  child: const ClientList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// class ProgressTrackerChild extends StatelessWidget {
//   const ProgressTrackerChild({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 198.0, // Half of the original height
//                       alignment: Alignment.center,
//                       child: const FilterStatus(),
//                     ),
//                     Container(
//                       height: 198.0, // Half of the original height
//                       alignment: Alignment.center,
//                       child: const DatePicker(),
//                     ),
//                     Container(
//                       alignment: Alignment.center,
//                       child: const ButtonApply(),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 396.0,
//                   alignment: Alignment.center,
//                   child: const ProgressBar(),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             height: 400.0,
//             alignment: Alignment.center,
//             child: ClientList(),
//           ),
//         ],
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/application/presentations/widgets/button_apply.dart';
// import 'package:revy/features/progress_tracker/bloc/get_params_bloc.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
// import '../widgets/client_list.dart';
// import '../widgets/date_picker.dart';
// import '../widgets/progress_bar.dart';
// import '../widgets/filter_status.dart';

// class ProgressTrackerApp extends StatelessWidget {
//   const ProgressTrackerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<GetParamsBloc>(
//           create: (context) => GetParamsBloc(),
//         ),
//         BlocProvider<ReadProgressBloc>(
//           create: (context) => ReadProgressBloc(),
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Progress Tracker',
//             style: TextStyle(
//               fontFamily: 'ArchivoBlack',
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: const ProgressTrackerChild(),
//       ),
//     );
//   }
// }

// class ProgressTrackerChild extends StatelessWidget {
//   const ProgressTrackerChild({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 198.0, // Half of the original height
//                       alignment: Alignment.center,
//                       child: const FilterStatus(),
//                     ),
//                     Container(
//                       height: 198.0, // Half of the original height
//                       alignment: Alignment.center,
//                       child: const DatePicker(),
//                     ),
//                     Container(
//                       alignment: Alignment.center,
//                       child: const ButtonApply(),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 200,
//                   alignment: Alignment.center,
//                   child: const ProgressBar(
//                       totalClients: 10,
//                       completedClients: 5), // Placeholder values
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             height: 400.0,
//             alignment: Alignment.center,
//             child: ClientList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
