import 'package:flutter/material.dart';
// import '../widgets/search_bar.dart';
import 'application/presentation/widgets/search_bar_with_places_api_widget.dart';
import 'application/presentation/widgets/client_preferences_widget.dart';
import 'application/presentation/widgets/suggested_schedule_widget.dart';
import 'application/presentation/widgets/select_sched_dates_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/create_schedule_bloc.dart';
import 'bloc/client_config_bloc.dart';

/// Flutter code sample for [Stepper].

// void main() => runApp(const StepperExampleApp());

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
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0 && _index < 3) {
          setState(() {
            _index -= 1;
          });
        }
        else {
          // Navigate back to the homepage
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      onStepContinue: () {
        if (_index >= 0 && _index < 3) {
          setState(() {
            _index += 1;
          });
        }
        else {
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
