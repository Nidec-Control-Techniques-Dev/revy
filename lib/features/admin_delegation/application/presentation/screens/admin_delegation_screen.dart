import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../bloc/delegation_bloc_2.dart';
import '../../../bloc/delegation_event_2.dart';
import '../../../bloc/delegation_state_2.dart';

class AdminDelegationScreen extends StatelessWidget {
  const AdminDelegationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DelegationBloc(),
      child: const DelegationPage(),
    );
  }
}

class DelegationPage extends StatelessWidget {
  const DelegationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delegation',
          style: TextStyle(fontWeight: FontWeight.bold), // Make the text bold
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<DelegationBloc, DelegationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Salesperson',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Salesperson 1', 'Salesperson 2', 'Salesperson 3']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      context
                          .read<DelegationBloc>()
                          .add(LoadSalespersonDetails(newValue!));
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Country: ${state.previousCountries.join(', ')}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          'State: ${state.previousStates.join(', ')}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Business Model: ${state.previousBusinessModels.join(', ')}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          'Business Category: ${state.previousBusinessCategories.join(', ')}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  MultiSelectDialogField(
                    items: ['Country 1', 'Country 2', 'Country 3']
                        .map((e) => MultiSelectItem<String>(e, e))
                        .toList(),
                    title: const Text("Edit Country"),
                    selectedColor: Colors.green,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    buttonText: const Text(
                      "Select Countries",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      context.read<DelegationBloc>().add(UpdateDetails(
                            salesperson: state.selectedSalesperson,
                            countries: results.cast<String>(),
                            states: state.states,
                            businessModels: state.businessModels,
                            businessCategories: state.businessCategories,
                          ));
                    },
                    initialValue: state.countries,
                  ),
                  const SizedBox(height: 16.0),
                  MultiSelectDialogField(
                    items: ['State 1', 'State 2', 'State 3']
                        .map((e) => MultiSelectItem<String>(e, e))
                        .toList(),
                    title: const Text("Edit State"),
                    selectedColor: Colors.green,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    buttonText: const Text(
                      "Select States",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      context.read<DelegationBloc>().add(UpdateDetails(
                            salesperson: state.selectedSalesperson,
                            countries: state.countries,
                            states: results.cast<String>(),
                            businessModels: state.businessModels,
                            businessCategories: state.businessCategories,
                          ));
                    },
                    initialValue: state.states,
                  ),
                  const SizedBox(height: 16.0),
                  MultiSelectDialogField(
                    items: ['Model 1', 'Model 2', 'Model 3']
                        .map((e) => MultiSelectItem<String>(e, e))
                        .toList(),
                    title: const Text("Edit Business Model"),
                    selectedColor: Colors.green,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    buttonText: const Text(
                      "Select Business Models",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      context.read<DelegationBloc>().add(UpdateDetails(
                            salesperson: state.selectedSalesperson,
                            countries: state.countries,
                            states: state.states,
                            businessModels: results.cast<String>(),
                            businessCategories: state.businessCategories,
                          ));
                    },
                    initialValue: state.businessModels,
                  ),
                  const SizedBox(height: 16.0),
                  MultiSelectDialogField(
                    items: ['Category 1', 'Category 2', 'Category 3']
                        .map((e) => MultiSelectItem<String>(e, e))
                        .toList(),
                    title: const Text("Edit Business Category"),
                    selectedColor: Colors.green,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    buttonText: const Text(
                      "Select Business Categories",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      context.read<DelegationBloc>().add(UpdateDetails(
                            salesperson: state.selectedSalesperson,
                            countries: state.countries,
                            states: state.states,
                            businessModels: state.businessModels,
                            businessCategories: results.cast<String>(),
                          ));
                    },
                    initialValue: state.businessCategories,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<DelegationBloc>().add(UpdateDetails(
                                salesperson: state.selectedSalesperson,
                                countries: state.previousCountries,
                                states: state.previousStates,
                                businessModels: state.previousBusinessModels,
                                businessCategories:
                                    state.previousBusinessCategories,
                              ));
                        },
                        child: const Text('Reset'),
                      ),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          context.read<DelegationBloc>().add(ApplyChanges());
                        },
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
