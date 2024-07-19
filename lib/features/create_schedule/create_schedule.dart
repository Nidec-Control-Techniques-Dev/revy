import 'package:flutter/material.dart';
import 'application/presentation/widgets/search_bar_with_places_api_widget.dart';
import 'application/presentation/widgets/client_preferences_widget.dart';
import 'application/presentation/widgets/suggested_schedule_widget.dart';
import 'application/presentation/widgets/select_sched_dates_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/create_schedule_bloc.dart';
import 'bloc/client_config_bloc.dart';
import 'bloc/schedule_bloc.dart';
import 'bloc/upload_schedule_bloc.dart';
import 'dart:async'; //

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
        BlocProvider<UploadScheduleBloc>(
          create: (context) => UploadScheduleBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Schedule'),
          automaticallyImplyLeading: false,
        ),
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
  bool _buttonsVisible = true;
  ScheduleState? _currentScheduleState;
  bool _showReminders = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScheduleBloc, ScheduleState>(
      listener: (context, schedState) {
        // _isSchedSaved == true
        if ((_index==3)){
          print("_isSchedSaved == true and _index == 3");
          if (schedState is ScheduleLoaded) {
             print("State is ScheduleLoaded");
            // scheduleState.companyRefs
            // ScheduleState.
            // state.
            _currentScheduleState = schedState;
            // context.read<UploadScheduleBloc>().add(SaveSchedule(
            //   companyRefs: schedState.companyRefs,
            //   availableCompanies: schedState.availableCompanies,
            //   companyAddresses: schedState.companyAddresses,
            //   annualSales: schedState.annualSales,
            //   businessModel: schedState.businessModel,
            //   categoryName: schedState.categoryName,
            //   subcategoryName: schedState.subcategoryName,
            //   contactNumber: schedState.contactNumber,
            //   email: schedState.email,
            //   faxNumber: schedState.faxNumber,
            // )); 
          }
        }

      },
      child: BlocListener<UploadScheduleBloc, UploadScheduleState>(
        listener: (context, state) {
          if (_index == 3) {
            // Handle the state changes when _index is 3
            if (state is ScheduleSavedState) {
               Navigator.popUntil(context, (route) => route.isFirst);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Success'),
                    content: const Text('Schedule saved successfully! View your schedule in Progress Tracker'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      ),
                    ],
                  );
                },
              );
            } else if (state is ScheduleErrorState) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Failed to save schedule.'),
                    actions: [
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
              const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
        child: BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
          builder: (context, state) {
            return Stepper(
              type: StepperType.horizontal,
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0 && _index < 3) {
                  setState(() {
                    _index -= 1;
                    // _showReminders = true;
                  });
                } else if (_index == 3) {
                  setState(() {
                    _index -= 3;
                  });
                } else {
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
              onStepContinue: () {
                if (_index == 0) {
                  if (_showReminders==true){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Reminder'),
                            content: const Text(
                              'Do not forget to search and choose your starting location.',
                              textAlign: TextAlign.left,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Select Starting Location'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: const Text('Location Already Selected'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                  setState(() {
                                    _index += 1;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    });
                  }
                  else{
                    setState(() {
                      _index += 1;
                    });
                  }
                }
                else if (_index == 1) {
                  if (_showReminders==true){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Reminder'),
                          content: const Text(
                            'Do not forget to select your schedule start and end dates.'
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Select Dates'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: const Text('Dates Already Selected'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                setState(() {
                                  _index += 1;
                                  _showReminders = false;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  });
                  }
                  else{
                    setState(() {
                      _index += 1;
                    });
                  }
                } else if (_index == 2) {
                  context.read<ScheduleBloc>().add(ResetSchedule(
                      startLocation: state.startLocation,
                      startDate: state.startDate,
                      endDate: state.endDate,
                      chosenStates: state.chosenStates,
                      chosenBusinessModels: state.chosenBusinessModels,
                      chosenCategories: state.chosenCategories
                  ));
                  if (state.startLocation.isEmpty ||
                      state.chosenStates.isEmpty ||
                      state.chosenBusinessModels.isEmpty ||
                      state.chosenCategories.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Incomplete details'),
                          content: RichText(
                            text: const TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Please make sure that you have provided the required details:\n\n',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: '• Starting Location\n',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: '• Schedule Start Date\n',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: '• Schedule End Date\n',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: '• Preferred States\n',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: '• Preferred Business Models\n',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: '• Preferred Categories\n',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                setState(() {
                                  _index -= 2;
                                  Navigator.of(context).pop(); 
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else {
                    
                    context.read<ScheduleBloc>().add(EmitSchedule(
                        startLocation: state.startLocation,
                        startDate: state.startDate,
                        endDate: state.endDate,
                        chosenStates: state.chosenStates,
                        chosenBusinessModels: state.chosenBusinessModels,
                        chosenCategories: state.chosenCategories));
                    setState(() {
                      _index += 1;
                      if (_index == 3) {
                        _buttonsVisible = false; // Hide the button
                        Timer(const Duration(seconds: 3), () {
                          setState(() {
                            _buttonsVisible = true; // Show the button again after 5 seconds
                          });
                        });
                      }

                    });
                  }

                } 
                // step 4: schedule
                else {
                  // context.read<ScheduleBloc>().add(SaveSched(
                  //   companyRefs: state.companyRefs,
                  //   availableCompanies: scheduleState.availableCompanies,
                  //   companyAddresses: scheduleState.companyAddresses,
                  //   annualSales: scheduleState.annualSales,
                  //   businessModel: scheduleState.businessModel,
                  //   categoryName: scheduleState.categoryName, 
                  //   subcategoryName: scheduleState.subcategoryName, 
                  //   contactNumber: scheduleState.contactNumber, 
                  //   email: scheduleState.email, 
                  //   faxNumber: scheduleState.faxNumber
                  // ));
                  // context.read<ScheduleBloc>().add(StartSaveSched());
                  
                  setState(() {
                    print(_index);
                    // _index += 1;
                    print(_index);
                    _buttonsVisible = false;
                    if (_currentScheduleState is ScheduleLoaded) {
                      ScheduleLoaded loadedState = _currentScheduleState as ScheduleLoaded;
                        context.read<UploadScheduleBloc>().add(SaveSchedule(
                          startingAddress: loadedState.startingAddress,
                          companyRefs: loadedState.companyRefs,
                          availableCompanies: loadedState.availableCompanies,
                          companyAddresses: loadedState.companyAddresses,
                          annualSales: loadedState.annualSales,
                          businessModel: loadedState.businessModel,
                          categoryName: loadedState.categoryName,
                          subcategoryName: loadedState.subcategoryName,
                          contactNumber: loadedState.contactNumber,
                          email: loadedState.email,
                          faxNumber: loadedState.faxNumber
                    )); 
                    }


                  });
                  // Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
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
                return _index == 3 && !_buttonsVisible
                    ? Container() // Hide buttons if _buttonsVisible is false
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: TextButton(
                              onPressed: _buttonsVisible ? details.onStepCancel : null,
                              child: Text(
                                _index == 3 ? 'Generate a New Schedule' : 'BACK',
                              ),
                            ),
                          ),
                          const Spacer(flex: 3),
                          Expanded(
                            child: TextButton(
                              onPressed: _buttonsVisible ? details.onStepContinue : null,
                              child: Text(
                                _index == 3 ? 'Save Schedule' : 'NEXT',
                              ),
                            ),
                          ),
                        ],
                      );
              },
            );
          },
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'application/presentation/widgets/search_bar_with_places_api_widget.dart';
// import 'application/presentation/widgets/client_preferences_widget.dart';
// import 'application/presentation/widgets/suggested_schedule_widget.dart';
// import 'application/presentation/widgets/select_sched_dates_widget.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'bloc/create_schedule_bloc.dart';
// import 'bloc/client_config_bloc.dart';
// import 'bloc/schedule_bloc.dart';
// import 'bloc/upload_schedule_bloc.dart';

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
//         BlocProvider<UploadScheduleBloc>(
//           create: (context) => UploadScheduleBloc(),
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Create Schedule'),
//           automaticallyImplyLeading: false,
//         ),
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
//   bool _buttonsVisible = true;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<UploadScheduleBloc, UploadScheduleState>(
//       listener: (context, state) {
//         if (_index == 3) {
//           // Handle the state changes when _index is 3
//           if (state is ScheduleSavedState) {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text('Success'),
//                   content: const Text('Schedule saved successfully! View your schedule in Progress Tracker'),
//                   actions: [
//                     TextButton(
//                       child: const Text('OK'),
//                       onPressed: () {
//                         // Navigator.of(context).pop();
//                         Navigator.popUntil(context, (route) => route.isFirst);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           } else if (state is ScheduleErrorState) {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text('Error'),
//                   content: const Text('Failed to save schedule.'),
//                   actions: [
//                     TextButton(
//                       child: const Text('OK'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           } else {
//             const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         }
//       },
//       child: BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
//         builder: (context, state) {
//           return Stepper(
//             type: StepperType.horizontal,
//             currentStep: _index,
//             onStepCancel: () {
//               if (_index > 0 && _index < 3) {
//                 setState(() {
//                   _index -= 1;
//                 });
//               } else if (_index == 3) {
//                 setState(() {
//                   _index -= 3;
//                 });
//               } else {
//                 Navigator.popUntil(context, (route) => route.isFirst);
//               }
//             },
//             onStepContinue: () {
//               if (_index >= 0 && _index < 2) {
//                 setState(() {
//                   _index += 1;
//                 });
//               } else if (_index == 2) {
//                 context.read<ScheduleBloc>().add(ResetSchedule(
//                     startLocation: state.startLocation,
//                     startDate: state.startDate,
//                     endDate: state.endDate,
//                     chosenStates: state.chosenStates,
//                     chosenBusinessModels: state.chosenBusinessModels,
//                     chosenCategories: state.chosenCategories
//                 ));
//                 if (state.startLocation.isEmpty ||
//                     state.chosenStates.isEmpty ||
//                     state.chosenBusinessModels.isEmpty ||
//                     state.chosenCategories.isEmpty) {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text('Incomplete details'),
//                         content: RichText(
//                           text: const TextSpan(
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: 'Please make sure that you have provided the required details:\n\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Starting Location\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Schedule Start Date\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Schedule End Date\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Preferred States\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Preferred Business Models\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Preferred Categories\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             child: const Text('OK'),
//                             onPressed: () {
//                               setState(() {
//                                 _index -= 2;
//                                 Navigator.of(context).pop(); 
//                               });
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//                 else {
//                   context.read<ScheduleBloc>().add(EmitSchedule(
//                       startLocation: state.startLocation,
//                       startDate: state.startDate,
//                       endDate: state.endDate,
//                       chosenStates: state.chosenStates,
//                       chosenBusinessModels: state.chosenBusinessModels,
//                       chosenCategories: state.chosenCategories));
//                   setState(() {
//                     _index += 1;
//                   });
//                 }

//               } 
//               // step 4: schedule
//               else {
//                 context.read<UploadScheduleBloc>().add(SaveSchedule());
//                 setState(() {
//                   _buttonsVisible = false;
//                 });
//                 // Navigator.popUntil(context, (route) => route.isFirst);
//               }
//             },
//             steps: <Step>[
//               Step(
//                   title: Row(
//                     children: [
//                       Icon(
//                         _index == 0
//                             ? Icons.location_on
//                             : (_index > 0
//                                 ? Icons.check_circle
//                                 : Icons.location_on),
//                         color: _index == 0 ? Colors.green : Colors.grey,
//                       ),
//                     ],
//                   ),
//                   content: Container(
//                       alignment: Alignment.centerLeft,
//                       child: const SearchBarWidget()),
//                   isActive: _index == 0),
//               Step(
//                   title: Row(
//                     children: [
//                       Icon(
//                         _index == 1
//                             ? Icons.calendar_month
//                             : (_index > 1
//                                 ? Icons.check_circle
//                                 : Icons.calendar_month),
//                         color: _index == 1 ? Colors.green : Colors.grey,
//                       ),
//                     ],
//                   ),
//                   content: Container(
//                       alignment: Alignment.centerLeft,
//                       child: const DatePickerWidget()),
//                   isActive: _index == 1),
//               Step(
//                   title: Row(
//                     children: [
//                       Icon(
//                         _index == 2
//                             ? Icons.people
//                             : (_index > 2 ? Icons.check_circle : Icons.people),
//                         color: _index == 2 ? Colors.green : Colors.grey,
//                       ),
//                     ],
//                   ),
//                   content: Container(
//                       alignment: Alignment.centerLeft,
//                       child: const ClientConfigWidget()),
//                   isActive: _index == 2),
//               Step(
//                   title: Row(
//                     children: [
//                       Icon(
//                         _index == 3
//                             ? Icons.smart_toy
//                             : (_index < 3 ? Icons.smart_toy : Icons.check_circle),
//                         color: _index == 3 ? Colors.green : Colors.grey,
//                       ),
//                     ],
//                   ),
//                   content: Container(
//                       alignment: Alignment.centerLeft,
//                       child: const SuggestedSchedWidget()),
//                   isActive: _index == 3),
//             ],
//             controlsBuilder: (BuildContext context, ControlsDetails details) {
//               return _index == 3 && !_buttonsVisible
//                   ? Container() // Hide buttons if _buttonsVisible is false
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Expanded(
//                           child: TextButton(
//                             onPressed: _buttonsVisible ? details.onStepCancel : null,
//                             child: Text(
//                               _index == 3 ? 'Generate a New Schedule' : 'BACK',
//                             ),
//                           ),
//                         ),
//                         const Spacer(flex: 3),
//                         Expanded(
//                           child: TextButton(
//                             onPressed: _buttonsVisible ? details.onStepContinue : null,
//                             child: Text(
//                               _index == 3 ? 'Save Schedule' : 'NEXT',
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


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
//     return BlocListener<ScheduleBloc, ScheduleState>(
//       listener: (context, state) {
//         if (_index == 3) {
//           // Handle the state changes when _index is 3
//           if (state is ScheduleSavedState) {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text('Success'),
//                   content: const Text('Schedule saved successfully! View your schedule in Progress Tracker'),
//                   actions: [
//                     TextButton(
//                       child: const Text('OK'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         // Navigator.popUntil(context, (route) => route.isFirst);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           } else if (state is ScheduleErrorState) {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text('Error'),
//                   content: const Text('Failed to save schedule.'),
//                   actions: [
//                     TextButton(
//                       child: const Text('OK'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//           else{
//               const Center(
//                 child: CircularProgressIndicator(),
//               );
//           }
//         }
//       },
//       child: BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
//         builder: (context, state) {
//           return Stepper(
//             type: StepperType.horizontal,
//             currentStep: _index,
//             onStepCancel: () {
//               if (_index > 0 && _index < 3) {
//                 setState(() {
//                   _index -= 1;
//                 });
//               } else if (_index == 3) {
//                 setState(() {
//                   _index -= 3;
//                 });
//               } else {
//                 Navigator.popUntil(context, (route) => route.isFirst);
//               }
//             },
//             onStepContinue: () {
//               if (_index >= 0 && _index < 2) {
//                 setState(() {
//                   _index += 1;
//                 });
//               } else if (_index == 2) {
//                 context.read<ScheduleBloc>().add(ResetSchedule(
//                     startLocation: state.startLocation,
//                     startDate: state.startDate,
//                     endDate: state.endDate,
//                     chosenStates: state.chosenStates,
//                     chosenBusinessModels: state.chosenBusinessModels,
//                     chosenCategories: state.chosenCategories
//                 ));
//                 if (state.startLocation.isEmpty ||
//                     state.chosenStates.isEmpty ||
//                     state.chosenBusinessModels.isEmpty ||
//                     state.chosenCategories.isEmpty) {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text('Incomplete details'),
//                         content: RichText(
//                           text: const TextSpan(
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: 'Please make sure that you have provided the required details:\n\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Starting Location\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Schedule Start Date\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Schedule End Date\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Preferred States\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Preferred Business Models\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               TextSpan(
//                                 text: '• Preferred Categories\n',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             child: const Text('OK'),
//                             onPressed: () {
//                               setState(() {
//                                 _index -= 2;
//                                 Navigator.of(context).pop(); 
//                               });
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//                 else {
//                   context.read<ScheduleBloc>().add(EmitSchedule(
//                       startLocation: state.startLocation,
//                       startDate: state.startDate,
//                       endDate: state.endDate,
//                       chosenStates: state.chosenStates,
//                       chosenBusinessModels: state.chosenBusinessModels,
//                       chosenCategories: state.chosenCategories));
//                   setState(() {
//                     _index += 1;
//                   });
//                 }

//               } 
//               // step 4: schedule
//               else {
//                 context.read<ScheduleBloc>().add(SaveSchedule(
//                   startLocation: state.startLocation,
//                   startDate: state.startDate,
//                   endDate: state.endDate,
//                   chosenStates: state.chosenStates,
//                   chosenBusinessModels: state.chosenBusinessModels,
//                   chosenCategories: state.chosenCategories));
//                 // Navigator.popUntil(context, (route) => route.isFirst);
//               }
//             },
//             steps: <Step>[
//               Step(
//                   title: Row(
//                     children: [
//                       Icon(
//                         _index == 0
//                             ? Icons.location_on
//                             : (_index > 0
//                                 ? Icons.check_circle
//                                 : Icons.location_on),
//                         color: _index == 0 ? Colors.green : Colors.grey,
//                       ),
//                     ],
//                   ),
//                   content: Container(
//                       alignment: Alignment.centerLeft,
//                       child: const SearchBarWidget()),
//                   isActive: _index == 0),
//               Step(
//                   title: Row(
//                     children: [
//                       Icon(
//                         _index == 1
//                             ? Icons.calendar_month
//                             : (_index > 1
//                                 ? Icons.check_circle
//                                 : Icons.calendar_month),
//                         color: _index == 1 ? Colors.green : Colors.grey,
//                       ),
//                     ],
//                   ),
//                   content: Container(
//                       alignment: Alignment.centerLeft,
//                       child: const DatePickerWidget()),
//                   isActive: _index == 1),
//               Step(
//                   title: Row(
//                     children: [
//                       Icon(
//                         _index == 2
//                             ? Icons.people
//                             : (_index > 2 ? Icons.check_circle : Icons.people),
//                         color: _index == 2 ? Colors.green : Colors.grey,
//                       ),
//                     ],
//                   ),
//                   content: Container(
//                       alignment: Alignment.centerLeft,
//                       child: const ClientConfigWidget()),
//                   isActive: _index == 2),
//               Step(
//                   title: Row(
//                     children: [
//                       Icon(
//                         _index == 3
//                             ? Icons.smart_toy
//                             : (_index < 3 ? Icons.smart_toy : Icons.check_circle),
//                         color: _index == 3 ? Colors.green : Colors.grey,
//                       ),
//                     ],
//                   ),
//                   content: Container(
//                       alignment: Alignment.centerLeft,
//                       child: const SuggestedSchedWidget()),
//                   isActive: _index == 3),
//             ],
//             controlsBuilder: (BuildContext context, ControlsDetails details) {
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Expanded(
//                     child: TextButton(
//                       onPressed: details.onStepCancel,
//                       child: Text(
//                         _index == 3 ? 'Generate a New Schedule' : 'BACK',
//                       ),
//                     ),
//                   ),
//                   const Spacer(flex: 3),
//                   Expanded(
//                     child: TextButton(
//                       onPressed: details.onStepContinue,
//                       child: Text(
//                         _index == 3 ? 'Save Schedule' : 'NEXT',
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


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
//             } else {
//               Navigator.popUntil(context, (route) => route.isFirst);
//             }
//           },
//           onStepContinue: () {
//             if (_index >= 0 && _index < 2) {
//               setState(() {
//                 _index += 1;
//               });
//             } else if (_index == 2) {
//               context.read<ScheduleBloc>().add(ResetSchedule(
//                   startLocation: state.startLocation,
//                   startDate: state.startDate,
//                   endDate: state.endDate,
//                   chosenStates: state.chosenStates,
//                   chosenBusinessModels: state.chosenBusinessModels,
//                   chosenCategories: state.chosenCategories
//               ));
//               if (state.startLocation.isEmpty ||
//                   state.chosenStates.isEmpty ||
//                   state.chosenBusinessModels.isEmpty ||
//                   state.chosenCategories.isEmpty) {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text('Incomplete details'),
//                       // content: const Text(
//                       //   '''Please make sure that you have provided the required details:\n
//                       //   - Starting Location
//                       //   - Preferred States
//                       //   - Preferred Business Models
//                       //   - Prefered Categories
//                       //   '''
//                       //   ,textAlign: TextAlign.left,
//                       // ),
//                       content: RichText(
//                         text: const TextSpan(
//                           children: <TextSpan>[
//                             TextSpan(
//                               text: 'Please make sure that you have provided the required details:\n\n',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             TextSpan(
//                               text: '• Starting Location\n',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             TextSpan(
//                               text: '• Schedule Start Date\n',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             TextSpan(
//                               text: '• Schedule End Date\n',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             TextSpan(
//                               text: '• Preferred States\n',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             TextSpan(
//                               text: '• Preferred Business Models\n',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             TextSpan(
//                               text: '• Preferred Categories\n',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ],
//                         ),
//                       ),
//                       actions: <Widget>[
//                         TextButton(
//                           child: const Text('OK'),
//                           onPressed: () {
//                             setState(() {
//                               _index -= 2;
//                               Navigator.of(context).pop(); 
//                             });
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               }
//               else {
//                 context.read<ScheduleBloc>().add(EmitSchedule(
//                     startLocation: state.startLocation,
//                     startDate: state.startDate,
//                     endDate: state.endDate,
//                     chosenStates: state.chosenStates,
//                     chosenBusinessModels: state.chosenBusinessModels,
//                     chosenCategories: state.chosenCategories));
//                 setState(() {
//                   _index += 1;
//                 });
//               }

//             } 
//             // step 4: schedule
//             else {
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
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Expanded(
//                       child: TextButton(
//                         onPressed: details.onStepCancel,
//                         child: Text(
//                           _index == 3 ? 'Generate a New Schedule' : 'BACK',
//                         ),
//                       ),
//                     ),
//                     const Spacer(flex: 3),
//                     Expanded(
//                       child: TextButton(
//                         onPressed: details.onStepContinue,
//                         child: Text(
//                           _index == 3 ? 'Save Schedule' : 'NEXT',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }


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
//             // page 2 and 3
//             if (_index > 0 && _index < 3) {
//               setState(() {
//                 _index -= 1;
//               });
//             }
//             else if (_index == 3){
//               setState(() {
//                 _index -= 3;
//               });
//             }
//             // page 1
//             else {
//               Navigator.popUntil(context, (route) => route.isFirst);
//             }
//           },
//           onStepContinue: () {
//             // page 1,2
//             if (_index >= 0 && _index < 2) {
//               setState(() {
//                 _index += 1;
//               });
//             } else if (_index == 2) {
//               context.read<ScheduleBloc>().add(ResetSchedule(
//                   startLocation: state.startLocation,
//                   startDate: state.startDate,
//                   endDate: state.endDate,
//                   chosenStates: state.chosenStates,
//                   chosenBusinessModels: state.chosenBusinessModels,
//                   chosenCategories: state.chosenCategories
//               ));
//               if (state.startLocation.isEmpty ||
//                   state.chosenStates.isEmpty ||
//                   state.chosenBusinessModels.isEmpty ||
//                   state.chosenCategories.isEmpty) {
//                 // print("At least one condition is met.");
//               }
//               context.read<ScheduleBloc>().add(EmitSchedule(
//                   startLocation: state.startLocation,
//                   startDate: state.startDate,
//                   endDate: state.endDate,
//                   chosenStates: state.chosenStates,
//                   chosenBusinessModels: state.chosenBusinessModels,
//                   chosenCategories: state.chosenCategories));
//               setState(() {
//                 _index += 1;
//               });
//             } else {
//               // Navigate back to the homepage
//               Navigator.popUntil(context, (route) => route.isFirst);
//             }
//           },
//           // onStepTapped: (int index) {
//           //   setState(() {
//           //     _index = index;
//           //   });
//           // },
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
//                 // Choose the dates of your schedule
//                 // title: const Text(''),
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
//                 // Choose the dates of your schedule
//                 // title: const Text(''),
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
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween, // Adjust alignment
//                   children: <Widget>[
//                     Expanded(
//                       // Wrap each button with Expanded
//                       child: TextButton(
//                         onPressed: details.onStepCancel,
//                         child: Text(
//                           _index == 3 ? 'Generate a New Schedule' : 'BACK',
//                         ),
//                       ),
//                     ),
//                     const Spacer(flex: 3), // Add a spacer for dynamic spacing
//                     Expanded(
//                       // Wrap each button with Expanded
//                       child: TextButton(
//                         onPressed: details.onStepContinue,
//                         child: Text(
//                           _index == 3 ? 'Save Schedule' : 'NEXT',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }


// Future<void> simulateTimeDelay() async {
//   print('Starting delay...');
//   await Future.delayed(Duration(seconds: 5)); // Delay for 5 seconds
//   print('Delay finished.');
// }


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