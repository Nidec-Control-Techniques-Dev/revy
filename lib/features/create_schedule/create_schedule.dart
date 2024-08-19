import 'package:flutter/material.dart';
import 'presentation/screens/search_bar_with_places_api_widget.dart';
import 'presentation/screens/select_sched_dates_widget.dart';
import 'presentation/screens/client_preferences_widget.dart';
import 'presentation/screens/suggested_schedule_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/create_schedule_bloc.dart';
import 'bloc/client_config_bloc.dart';
import 'bloc/schedule_bloc.dart';
import 'bloc/upload_schedule_bloc.dart';
import 'dart:async';

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
          title: const Text(
            'Create Schedule',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.home, color: Colors.green,),
            onPressed: () {
               Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.report, color: Colors.red,),
          //     onPressed: () {
          //        Navigator.popUntil(context, (route) => route.isFirst);
          //     },
          //   ),
          // ],
        ),
        body: const CreateScheduleStepper() 
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
          if (schedState is ScheduleLoaded) {
            _currentScheduleState = schedState;
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
            }
            else {
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
                  
                  setState(() {
                    _buttonsVisible = false;
                    if (_currentScheduleState is ScheduleLoaded) {
                      ScheduleLoaded loadedState = _currentScheduleState as ScheduleLoaded;
                        context.read<UploadScheduleBloc>().add(SaveSchedule(
                          scheduleDates: loadedState.scheduleDates,
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
                                  : Icons.location_on
                                ),
                          color: _index == 0 ? Colors.green : Colors.grey,
                        ),
                      ],
                    ),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const SingleChildScrollView(
                          child: SearchBarWidget()
                        ) 
                    ),
                    isActive: _index == 0
                ),
                Step(
                    title: Row(
                      children: [
                        Icon(
                          _index == 1
                              ? Icons.calendar_month
                              : (_index > 1 ? Icons.check_circle: Icons.calendar_month),
                          color: _index == 1 ? Colors.green : Colors.grey,
                        ),
                      ],
                    ),
                    content: Container(
                        alignment: Alignment.centerLeft,
                        child: const DatePickerWidget()
                    ),
                    isActive: _index == 1
                ),
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
                        child: const ClientConfigWidget()
                    ),
                    isActive: _index == 2
                ),
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
                        child: const SuggestedSchedWidget()
                    ),
                    isActive: _index == 3
                ),
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
