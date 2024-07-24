import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'client_list.dart';
import '../../bloc/filter_bloc.dart';
// import 'date.dart';
// import 'package:pie_chart/pie_chart.dart';
// import '../../data/repository/assigned_users.dart';
import '../../bloc/assigned_users_bloc.dart';
import '../screens/filter_screen_content.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Admin Analytics',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FilterBloc(),
          ),
          BlocProvider(
            create: (context) => AssignedUsersBloc()..add(InitialState()),
          ),
        ],
        child: const FilterScreenContent(),
      ),
    );
  }
}