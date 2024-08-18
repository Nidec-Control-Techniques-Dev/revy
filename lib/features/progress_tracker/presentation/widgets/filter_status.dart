
import 'package:flutter/material.dart';
import '../../bloc/get_params_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterStatus extends StatefulWidget {
  const FilterStatus({super.key});

  @override
  _FilterStatusState createState() => _FilterStatusState();
}

class _FilterStatusState extends State<FilterStatus> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = 'All';
    context.read<GetParamsBloc>().add(FilterStatusChanged(filterStatus: selectedOption));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20), // Horizontal padding of 20
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns the label to the start
        children: <Widget>[
          const Text(
            'Select Filter Status',
            style:  TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(
              height:
                  8), // Adds some spacing between the label and the dropdown
          Container(
            padding: const EdgeInsets.all(8), // Padding inside the container
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // Position of shadow
                ),
              ],
              borderRadius:
                  BorderRadius.circular(10), // Apply border radius of 5
              border: Border.all(
                  color: Colors.green, width: 2), // Green border with width 2
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isDense: true,
                isExpanded:
                    true, // Make the dropdown button expand to fill available space
                style: const TextStyle(
                    color: Colors.black, fontSize: 10), // Text style
                value: selectedOption,
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.black), // Arrow icon
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue;
                    context
                        .read<GetParamsBloc>()
                        .add(FilterStatusChanged(filterStatus: newValue));
                  });
                },
                items: <String>['All', 'Visited', 'Unvisited']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                      // Wrap the Text widget with Center to align it in the middle
                      child: Text(
                        value,
                        textAlign:
                            TextAlign.center, // Align the text to the center
                        style: const TextStyle(
                            fontSize: 14), // Menu item text style
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
