import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'client_list.dart';
import '../../bloc/filter_bloc.dart';
import 'date.dart';
import 'package:pie_chart/pie_chart.dart';
// import '../../data/repository/assigned_users.dart';
import '../../bloc/assigned_users_bloc.dart';

class FilterScreenContent extends StatefulWidget {
  const FilterScreenContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilterScreenContentState createState() => _FilterScreenContentState();
}

class _FilterScreenContentState extends State<FilterScreenContent> {
  
  // ignore: prefer_final_fields
  // List<String> _salesPersonOptions = ["Choose a Filter"];
  UsersData? dataStateCopy;
  // final List<String> _salesPersonOptions = [
  //   'Choose a Filter',
  //   'All',
  //   'Company 1',
  //   'Company 2'
  // ];
  // final Future<List> _salesPersonOptions = getAssignedUsers();
  final List<String> _dateOptions = [
    'All',
    'Today',
    'Last 7 Days',
    'Last 30 Days'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignedUsersBloc, UsersData>(
      builder: (context, dataState) {
        
        if (dataState is DataNotLoaded){
          return const Center(
              child: CircularProgressIndicator(),
            );
        }
        else {
          dataStateCopy = dataState;
          if (dataStateCopy is DataLoaded){
            DataLoaded loadedState = dataStateCopy as DataLoaded;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Sales Person/s:',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    _buildDropdown(
                      // loadedState.salesPeopleNames[0],
                      null,
                      loadedState.salesPeopleNames,
                      'Select a sales person',
                      // _salesPersonOptions as List<String>,
                      (String? newValue) {
                        int index = loadedState.salesPeopleNames.indexOf(newValue!);
                        context
                            .read<FilterBloc>()
                            .add(TempFilter1Changed(newValue, loadedState.salesPeopleRef[index]));
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Select Date/s:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    _buildDropdown(
                      null,
                      // _dateOptions[0],
                      _dateOptions,
                      'Select date/s',
                      (String? newValue) {
                        context
                            .read<FilterBloc>()
                            .add(TempFilter2Changed(newValue!));
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<FilterBloc>().add(ApplyFilters());
                        },
                        child: const Text('Apply Filters'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                        if (state.displayText.isNotEmpty &&
                            state.selectedFilter1 != 'Choose a Filter' &&
                            state.selectedFilter2 == 'Today') {
                          return CurrentDate();
                        } else if (state.displayText.isNotEmpty &&
                            state.selectedFilter1 != 'Choose a Filter' &&
                            state.selectedFilter2 == 'Last 7 Days') {
                          return LastSevenDays();
                        } else if (state.displayText.isNotEmpty &&
                            state.selectedFilter1 != 'Choose a Filter' &&
                            state.selectedFilter2 == 'Last 30 Days') {
                          return LastThirtyDays();
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                        if (state.displayText.isNotEmpty &&
                            state.selectedFilter2 != 'Choose a Filter') {
                          return Column(
                            children: [
                              _buildResultBox(state),
                              const SizedBox(height: 20),
                              Container(
                                height: 400.0,
                                alignment: Alignment.center,
                                child: ClientListCompany1(),
                              ),
                            ],
                          );
                        }
                        if (state.displayText.isNotEmpty &&
                            state.selectedFilter2 != 'Choose a Filter') {
                          return Column(
                            children: [
                              _buildResultBox(state),
                              const SizedBox(height: 20),
                              Container(
                                height: 400.0,
                                alignment: Alignment.center,
                                child: ClientListCompany2(),
                              ),
                            ],
                          );
                        }
                        if (state.displayText.isNotEmpty &&
                            state.selectedFilter1 == 'All' &&
                            state.selectedFilter2 != 'Choose a Filter') {
                          return Column(
                            children: [
                              _buildResultBox(state),
                              const SizedBox(height: 20),
                              Container(
                                height: 400.0,
                                alignment: Alignment.center,
                                child: ClientListCompanyAll(),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          else{
            return const Center(
                child: CircularProgressIndicator(),
            );
          }

        }

      },
    );
  }

  // Widget _buildDropdown(String selectedValue, List<String> options,
  //     ValueChanged<String?> onChanged) {
  //   return DropdownButtonFormField<String>(
  //     value: selectedValue,
  //     onChanged: onChanged,
  //     decoration: InputDecoration(
  //       fillColor: Colors.white,
  //       filled: true,
  //       contentPadding:
  //           const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //     ),
  //     items: options.map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(
  //           value,
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

Widget _buildDropdown(String? selectedValue, List<String> options, String hint, ValueChanged<String?> onChanged) {
  return DropdownButtonFormField<String>(
    value: selectedValue, // Accept nullable String for selectedValue
    onChanged: onChanged,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      hintText: hint, // Use the provided hint text
    ),
    items: options.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList(),
  );
}


  Widget _buildResultBox(FilterState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _buildBox('Visited', state.visitedCount.toString())),
            const SizedBox(width: 10),
            Expanded(
                child:
                    _buildBox('Not Visited', state.notVisitedCount.toString())),
            const SizedBox(width: 10),
            Expanded(
                child: _buildBox('Ongoing', state.ongoingCount.toString())),
            const SizedBox(width: 10),
            Expanded(child: _buildBox('Total', state.total.toString())),
          ],
        ),
        const SizedBox(height: 20),
        if (state.dataMap.isNotEmpty) _buildPieChart(state.dataMap),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(Map<String, double> dataMap) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      colorList: const [
        Color.fromARGB(255, 165, 230, 167),
        Color.fromARGB(255, 238, 147, 140),
        const Color.fromARGB(255, 243, 233, 147)
      ],
      ringStrokeWidth: 32,
      legendOptions: const LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
