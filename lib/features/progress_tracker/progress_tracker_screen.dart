import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revy/features/progress_tracker/presentation/widgets/button_apply.dart';
import 'package:revy/features/progress_tracker/bloc/get_params_bloc.dart';
import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
import 'presentation/widgets/client_list.dart';
import 'presentation/widgets/date_picker.dart';
import 'presentation/widgets/progress_bar.dart';
import 'presentation/widgets/filter_status.dart';
import '../progress_tracker/presentation/widgets/map.dart';
// import 'presentation/widgets/client_list_legend.dart';
// import 'bloc/update_status_bloc.dart';

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
        // BlocProvider<UpdateStatusBloc>(
        //   create: (context) => UpdateStatusBloc()
        // ) 
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Progress Tracker',
            style: TextStyle(
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
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: const ProgressBar(),
                ),
                // Container(
                //   height: 100, // Half of the original height
                //   alignment: Alignment.center,
                //   child: const FilterStatus(),
                // ),
                const DatePicker(),
                // const SizedBox(
                //   height: 200, // Half of the original height
                //   width: double.infinity,
                //   child: DatePicker(),
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   child: const LegendRow(),
                // ),
                // const SizedBox(height: 15),
                const SizedBox(height: 15),
                const SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: MapScreen()
                ),
                const SizedBox(height: 15),
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
