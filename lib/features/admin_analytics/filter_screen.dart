import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'client_list.dart';
import 'filter_bloc.dart';
import 'date.dart';
import 'package:pie_chart/pie_chart.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Analytics', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: BlocProvider(
        create: (context) => FilterBloc(),
        child: FilterScreenContent(),
      ),
    );
  }
}

class FilterScreenContent extends StatefulWidget {
  @override
  _FilterScreenContentState createState() => _FilterScreenContentState();
}

class _FilterScreenContentState extends State<FilterScreenContent> {
  final List<String> _salesPersonOptions = ['Choose a Filter', 'All', 'Company 1', 'Company 2'];
  final List<String> _dateOptions = ['Choose a Filter', 'All', 'Today', 'Last 7 Days', 'Last 30 Days'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sales Person:', style: TextStyle(fontWeight: FontWeight.bold)),
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                return _buildDropdown(
                  state.tempSelectedFilter1,
                  _salesPersonOptions,
                  (String? newValue) {
                    context.read<FilterBloc>().add(TempFilter1Changed(newValue!));
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Text('Date:', style: TextStyle(fontWeight: FontWeight.bold)),
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                return _buildDropdown(
                  state.tempSelectedFilter2,
                  _dateOptions,
                  (String? newValue) {
                    context.read<FilterBloc>().add(TempFilter2Changed(newValue!));
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<FilterBloc>().add(ApplyFilters());
                },
                child: Text('Apply Filters'),
              ),
            ),
            SizedBox(height: 20),
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                if (state.displayText.isNotEmpty && state.selectedFilter1 != 'Choose a Filter' && state.selectedFilter2 == 'Today') {
                  return CurrentDate();
                } else if (state.displayText.isNotEmpty && state.selectedFilter1 != 'Choose a Filter' && state.selectedFilter2 == 'Last 7 Days') {
                  return LastSevenDays();
                } else if (state.displayText.isNotEmpty && state.selectedFilter1 != 'Choose a Filter' && state.selectedFilter2 == 'Last 30 Days') {
                  return LastThirtyDays();
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                if (state.displayText.isNotEmpty && state.selectedFilter1 == 'Company 1' && state.selectedFilter2 != 'Choose a Filter') {
                  return Column(
                    children: [
                      _buildResultBox(state),
                      SizedBox(height: 20),
                      Container(
                        height: 400.0,
                        alignment: Alignment.center,
                        child: ClientListCompany1(),
                      ),
                    ],
                  );
                } 
                if (state.displayText.isNotEmpty && state.selectedFilter1 == 'Company 2' && state.selectedFilter2 != 'Choose a Filter') {
                  return Column(
                    children: [
                      _buildResultBox(state),
                      SizedBox(height: 20),
                      Container(
                        height: 400.0,
                        alignment: Alignment.center,
                        child: ClientListCompany2(),
                      ),
                    ],
                  );
                } 
                if (state.displayText.isNotEmpty && state.selectedFilter1 == 'All' && state.selectedFilter2 != 'Choose a Filter') {
                  return Column(
                    children: [
                      _buildResultBox(state),
                      SizedBox(height: 20),
                      Container(
                        height: 400.0,
                        alignment: Alignment.center,
                        child: ClientListCompanyAll(),
                      ),
                    ],
                  );
                }
                else {
                  return SizedBox.shrink();
                }
              },

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String selectedValue, List<String> options, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
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
            Expanded(child: _buildBox('Visited', state.visitedCount.toString())),
            SizedBox(width: 10),
            Expanded(child: _buildBox('Not Visited', state.notVisitedCount.toString())),
            SizedBox(width: 10),
            Expanded(child: _buildBox('Ongoing', state.ongoingCount.toString())),
            SizedBox(width: 10),
            Expanded(child: _buildBox('Total', state.total.toString())),
          ],
        ),
        SizedBox(height: 20),
        if (state.dataMap.isNotEmpty) _buildPieChart(state.dataMap),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBox(String title, String value) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(Map<String, double> dataMap) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      colorList: [Color.fromARGB(255, 165, 230, 167), const Color.fromARGB(255, 238, 147, 140), const Color.fromARGB(255, 243, 233, 147)],
      ringStrokeWidth: 32,
      legendOptions: LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
