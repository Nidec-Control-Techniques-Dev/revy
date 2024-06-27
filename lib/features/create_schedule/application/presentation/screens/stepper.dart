import 'package:flutter/material.dart';
// import '../widgets/search_bar.dart';
import '../widgets/search_bar_with_places_api_widget.dart';
import '../widgets/client_preferences_widget.dart';
import '../widgets/suggested_schedule_widget.dart';
import '../widgets/select_sched_dates_widget.dart';

/// Flutter code sample for [Stepper].

void main() => runApp(const StepperExampleApp());

class StepperExampleApp extends StatelessWidget {
  const StepperExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Stepper Sample')),
        body: const Center(
          child: StepperExample(),
        ),
      ),
    );
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          // Where are you coming from?
          title: const Text(''),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const SearchBarWidget()
          ),
        ),
        Step(
          // Choose the dates of your schedule
          title: const Text(''),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const DatePickerWidget()
          )
        ),
        Step(
          // Choose the dates of your schedule
          title: const Text(''),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const ClientConfigWidget()
          )
        ),
        Step(
          // Choose the dates of your schedule
          title: const Text(''),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const SuggestedSchedWidget()
          )
        ),
      ],
    );
  }
}
