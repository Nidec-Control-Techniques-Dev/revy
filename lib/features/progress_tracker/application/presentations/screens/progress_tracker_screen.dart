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
        BlocProvider<ReadProgressBloc>(
          create: (context) => ReadProgressBloc(),
        ),
        BlocProvider<GetParamsBloc>(
          create: (context) => GetParamsBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Progress Tracker')),
        body: const ProgressTrackerChild(),
      ),
    );
  }
}

class ProgressTrackerChild extends StatelessWidget {
  const ProgressTrackerChild({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 198.0, // Half of the original height
                      alignment: Alignment.center,
                      child: const FilterStatus(),
                    ),
                    Container(
                      height: 198.0, // Half of the original height
                      alignment: Alignment.center,
                      child: const DatePicker(),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const ButtonApply(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xffeeee00),
                  height: 396.0,
                  alignment: Alignment.center,
                  child: const ProgressBar(),
                ),
              ),
            ],
          ),
          Container(
            height: 400.0,
            alignment: Alignment.center,
            child: ClientList(),
          ),
        ],
      ),
    );
  }
}
