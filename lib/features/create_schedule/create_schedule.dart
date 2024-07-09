// import 'package:flutter/material.dart';
// import 'application/presentation/widgets/search_bar_with_places_api_widget.dart';
// import 'application/presentation/widgets/client_preferences_widget.dart';
// import 'application/presentation/widgets/suggested_schedule_widget.dart';
// import 'application/presentation/widgets/select_sched_dates_widget.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'bloc/create_schedule_bloc.dart';
// import 'bloc/client_config_bloc.dart';
// import 'bloc/schedule_bloc.dart';

// class CreateScheduleScreen extends StatelessWidget {
//   const CreateScheduleScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<CreateScheduleBloc>(
//           create: (context) => CreateScheduleBloc(),
//         ),
//         BlocProvider<DataBloc>(
//           create: (context) => DataBloc()..add(InitializeSupabase()),
//         ),
//         BlocProvider<ScheduleBloc>(
//           create: (context) => ScheduleBloc(),
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Create Schedule')),
//         body: const CreateScheduleStepper(),
//       ),
//     );
//   }
// }

// class CreateScheduleStepper extends StatefulWidget {
//   const CreateScheduleStepper({super.key});

//   @override
//   State<CreateScheduleStepper> createState() => _StepperState();
// }

// class _StepperState extends State<CreateScheduleStepper> {
//   int _index = 0;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
//       builder: (context, state) {
//         return Stepper(
//           type: StepperType.horizontal,
//           currentStep: _index,
//           onStepCancel: () {
//             if (_index > 0 && _index < 3) {
//               setState(() {
//                 _index -= 1;
//               });
//             } else if (_index == 3) {
//               setState(() {
//                 _index -= 3;
//               });
//             }
//           },
//           onStepContinue: () {
//             if (_index >= 0 && _index < 2) {
//               setState(() {
//                 _index += 1;
//               });
//             } else if (_index == 2) {
//               List<String> missingFields = [];

//               if (state.startLocation == null) missingFields.add('Start Location');
//               if (state.startDate == null) missingFields.add('Start Date');
//               if (state.endDate == null) missingFields.add('End Date');
//               if (state.chosenStates == null) missingFields.add('Chosen States');
//               if (state.chosenBusinessModels == null) missingFields.add('Chosen Business Models');
//               if (state.chosenCategories == null) missingFields.add('Chosen Categories');

//               if (missingFields.isNotEmpty) {
//                 _showAlertDialog(context, missingFields);
//               } else {
//                 context.read<ScheduleBloc>().add(ResetSchedule(
//                     startLocation: state.startLocation,
//                     startDate: state.startDate,
//                     endDate: state.endDate,
//                     chosenStates: state.chosenStates,
//                     chosenBusinessModels: state.chosenBusinessModels,
//                     chosenCategories: state.chosenCategories
//                 ));
//                 context.read<ScheduleBloc>().add(EmitSchedule(
//                     startLocation: state.startLocation,
//                     startDate: state.startDate,
//                     endDate: state.endDate,
//                     chosenStates: state.chosenStates,
//                     chosenBusinessModels: state.chosenBusinessModels,
//                     chosenCategories: state.chosenCategories
//                 ));
//                 setState(() {
//                   _index += 1;
//                 });
//               }
//             } else {
//               Navigator.popUntil(context, (route) => route.isFirst);
//             }
//           },
//           steps: <Step>[
//             Step(
//                 title: Row(
//                   children: [
//                     Icon(
//                       _index == 0
//                           ? Icons.location_on
//                           : (_index > 0
//                               ? Icons.check_circle
//                               : Icons.location_on),
//                       color: _index == 0 ? Colors.green : Colors.grey,
//                     ),
//                   ],
//                 ),
//                 content: Container(
//                     alignment: Alignment.centerLeft,
//                     child: const SearchBarWidget()),
//                 isActive: _index == 0),
//             Step(
//                 title: Row(
//                   children: [
//                     Icon(
//                       _index == 1
//                           ? Icons.calendar_month
//                           : (_index > 1
//                               ? Icons.check_circle
//                               : Icons.calendar_month),
//                       color: _index == 1 ? Colors.green : Colors.grey,
//                     ),
//                   ],
//                 ),
//                 content: Container(
//                     alignment: Alignment.centerLeft,
//                     child: const DatePickerWidget()),
//                 isActive: _index == 1),
//             Step(
//                 title: Row(
//                   children: [
//                     Icon(
//                       _index == 2
//                           ? Icons.people
//                           : (_index > 2 ? Icons.check_circle : Icons.people),
//                       color: _index == 2 ? Colors.green : Colors.grey,
//                     ),
//                   ],
//                 ),
//                 content: Container(
//                     alignment: Alignment.centerLeft,
//                     child: const ClientConfigWidget()),
//                 isActive: _index == 2),
//             Step(
//                 title: Row(
//                   children: [
//                     Icon(
//                       _index == 3
//                           ? Icons.smart_toy
//                           : (_index < 3 ? Icons.smart_toy : Icons.check_circle),
//                       color: _index == 3 ? Colors.green : Colors.grey,
//                     ),
//                   ],
//                 ),
//                 content: Container(
//                     alignment: Alignment.centerLeft,
//                     child: const SuggestedSchedWidget()),
//                 isActive: _index == 3),
//           ],
//           controlsBuilder: (BuildContext context, ControlsDetails details) {
//             return Row(
//               children: <Widget>[
//                 TextButton(
//                   onPressed: details.onStepCancel,
//                   child: Text(
//                     _index == 3 ? 'Generate a New Schedule' : 'BACK',
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: details.onStepContinue,
//                   child: Text(
//                     _index == 3 ? 'Save Schedule' : 'NEXT',
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   void _showAlertDialog(BuildContext context, List<String> missingFields) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Incomplete Information'),
//           content: Text('Please fill in the following fields:\n' + missingFields.join('\n')),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'application/presentation/widgets/search_bar_with_places_api_widget.dart';
import 'application/presentation/widgets/client_preferences_widget.dart';
import 'application/presentation/widgets/suggested_schedule_widget.dart';
import 'application/presentation/widgets/select_sched_dates_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/create_schedule_bloc.dart';
import 'bloc/client_config_bloc.dart';
import 'bloc/schedule_bloc.dart';

class CreateScheduleScreen extends StatelessWidget {
  const CreateScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateScheduleBloc>(
          create: (context) => CreateScheduleBloc(),
        ),
        BlocProvider<DataBloc>(
          create: (context) => DataBloc()..add(InitializeSupabase()),
        ),
        BlocProvider<ScheduleBloc>(
          create: (context) => ScheduleBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Schedule')),
        body: const CreateScheduleStepper(),
      ),
    );
  }
}

class CreateScheduleStepper extends StatefulWidget {
  const CreateScheduleStepper({super.key});

  @override
  State<CreateScheduleStepper> createState() => _StepperState();
}

class _StepperState extends State<CreateScheduleStepper> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
      builder: (context, state) {
        return Stepper(
          type: StepperType.horizontal,
          currentStep: _index,

          onStepCancel: () {
            // page 2 and 3
            if (_index > 0 && _index < 3) {
              setState(() {
                _index -= 1;
              });
            }
            else if (_index == 3){
              setState(() {
                _index -= 3;
              });
            }
            // page 1
            else {
              // // Navigate back to the homepage
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          },
          onStepContinue: () {
            // page 1,2
            if (_index >= 0 && _index < 2) {
              setState(() {
                _index += 1;
              });
            } else if (_index == 2) {
              context.read<ScheduleBloc>().add(ResetSchedule(
                  startLocation: state.startLocation,
                  startDate: state.startDate,
                  endDate: state.endDate,
                  chosenStates: state.chosenStates,
                  chosenBusinessModels: state.chosenBusinessModels,
                  chosenCategories: state.chosenCategories
              ));
              context.read<ScheduleBloc>().add(EmitSchedule(
                  startLocation: state.startLocation,
                  startDate: state.startDate,
                  endDate: state.endDate,
                  chosenStates: state.chosenStates,
                  chosenBusinessModels: state.chosenBusinessModels,
                  chosenCategories: state.chosenCategories));
              setState(() {
                _index += 1;
              });
            } else {
              // Navigate back to the homepage
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          },
          // onStepTapped: (int index) {
          //   setState(() {
          //     _index = index;
          //   });
          // },
          steps: <Step>[
            Step(
                title: Row(
                  children: [
                    Icon(
                      _index == 0
                          ? Icons.location_on
                          : (_index > 0
                              ? Icons.check_circle
                              : Icons.location_on),
                      color: _index == 0 ? Colors.green : Colors.grey,
                    ),
                  ],
                ),
                content: Container(
                    alignment: Alignment.centerLeft,
                    child: const SearchBarWidget()),
                isActive: _index == 0),
            Step(
                title: Row(
                  children: [
                    Icon(
                      _index == 1
                          ? Icons.calendar_month
                          : (_index > 1
                              ? Icons.check_circle
                              : Icons.calendar_month),
                      color: _index == 1 ? Colors.green : Colors.grey,
                    ),
                  ],
                ),
                content: Container(
                    alignment: Alignment.centerLeft,
                    child: const DatePickerWidget()),
                isActive: _index == 1),
            Step(
                // Choose the dates of your schedule
                // title: const Text(''),
                title: Row(
                  children: [
                    Icon(
                      _index == 2
                          ? Icons.people
                          : (_index > 2 ? Icons.check_circle : Icons.people),
                      color: _index == 2 ? Colors.green : Colors.grey,
                    ),
                  ],
                ),
                content: Container(
                    alignment: Alignment.centerLeft,
                    child: const ClientConfigWidget()),
                isActive: _index == 2),
            Step(
                // Choose the dates of your schedule
                // title: const Text(''),
                title: Row(
                  children: [
                    Icon(
                      _index == 3
                          ? Icons.smart_toy
                          : (_index < 3 ? Icons.smart_toy : Icons.check_circle),
                      color: _index == 3 ? Colors.green : Colors.grey,
                    ),
                  ],
                ),
                content: Container(
                    alignment: Alignment.centerLeft,
                    child: const SuggestedSchedWidget()),
                isActive: _index == 3),
          ],
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Adjust alignment
                  children: <Widget>[
                    Expanded(
                      // Wrap each button with Expanded
                      child: TextButton(
                        onPressed: details.onStepCancel,
                        child: Text(
                          _index == 3 ? 'Generate a New Schedule' : 'BACK',
                        ),
                      ),
                    ),
                    const Spacer(flex: 3), // Add a spacer for dynamic spacing
                    Expanded(
                      // Wrap each button with Expanded
                      child: TextButton(
                        onPressed: details.onStepContinue,
                        child: Text(
                          _index == 3 ? 'Save Schedule' : 'NEXT',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
// Future<void> simulateTimeDelay() async {
//   print('Starting delay...');
//   await Future.delayed(Duration(seconds: 5)); // Delay for 5 seconds
//   print('Delay finished.');
// }
