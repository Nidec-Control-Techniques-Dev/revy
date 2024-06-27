import 'package:flutter/material.dart';
import '../../../bloc/get_params_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterStatus extends StatefulWidget {
  const FilterStatus({super.key});

  @override
  _FilterStatusState createState() => _FilterStatusState();
}

class _FilterStatusState extends State<FilterStatus> {
  String? selectedOption; // Initialize selectedOption here

  @override
  void initState() {
    super.initState();
    selectedOption = 'All'; // Set the default value to 'All'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: DropdownButton<String>(
          value: selectedOption,
          icon: const Icon(Icons.arrow_downward),
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue;
              //trigger events to get the params from get_params_bloc
              context
                  .read<GetParamsBloc>()
                  .add(FilterStatusChanged(filterStatus: newValue));
            });
          },
          items: <String>['All', 'Visited', 'Unvisited', 'Ongoing']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
