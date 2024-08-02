import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../bloc/delegation_bloc_2.dart';
import '../../../bloc/assigned_salesperson_bloc.dart';
import '../widgets/current_config_widget.dart';

class AdminDelegationScreen extends StatelessWidget {
  const AdminDelegationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Admin Delegation'),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AssignedSalespersonBloc>(
            create: (context) => AssignedSalespersonBloc()..add(InitialState()),
          ),
          BlocProvider<DelegationBloc>(
            create: (context) => DelegationBloc(),
          ),
        ],
        child: const DelegationPage(),
      ),
    );
  }
}

class DelegationPage extends StatelessWidget {
  const DelegationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignedSalespersonBloc, AssignedSalespersonState>(
      builder: (context, userDataState) {
        if (userDataState is DataNotLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (userDataState is DataLoaded) {
          return Padding(
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
                        items: userDataState.salesPeopleNames.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          int index = userDataState.salesPeopleNames.indexOf(newValue!);
                          context.read<DelegationBloc>().add(
                            LoadSalespersonDetails(newValue, userDataState.salesPeopleRef[index]),
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      const AccordionPage(),
                      const SizedBox(height: 16.0),
                      if (state.countries.isNotEmpty) ...[
                        const Text(
                          "New delegations",
                          style: TextStyle(
                            fontSize: 24, // Set the font size to a heading size
                            fontWeight: FontWeight.bold, // Make the text bold
                          ),
                          textAlign: TextAlign.left,
                        ),
                        MultiSelectDialogField(
                          items: userDataState.countries.map((item) => item['name']).toList()
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
                              salespersonRef: state.selectedSalespersonRef,
                              countries: results,
                              states: state.states,
                              businessModels: state.businessModels,
                              businessCategories: state.businessCategories,
                            ));
                          },
                          initialValue: state.countries,
                        ),
                        const SizedBox(height: 16.0),
                        MultiSelectDialogField(
                          items: userDataState.states.map((item) => item['name']).toList()
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
                              salespersonRef: state.selectedSalespersonRef,
                              countries: state.countries,
                              states: results,
                              businessModels: state.businessModels,
                              businessCategories: state.businessCategories,
                            ));
                          },
                          initialValue: state.states,
                        ),
                        const SizedBox(height: 16.0),
                        MultiSelectDialogField(
                          items: userDataState.businessModels.map((item) => item['name']).toList()
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
                              salespersonRef: state.selectedSalespersonRef,
                              countries: state.countries,
                              states: state.states,
                              businessModels: results,
                              businessCategories: state.businessCategories,
                            ));
                          },
                          initialValue: state.businessModels,
                        ),
                        const SizedBox(height: 16.0),
                        MultiSelectDialogField(
                          items: userDataState.categories.map((item) => item['name']).toList()
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
                              salespersonRef: state.selectedSalespersonRef,
                              countries: state.countries,
                              states: state.states,
                              businessModels: state.businessModels,
                              businessCategories: results,
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
                                  salespersonRef: state.selectedSalespersonRef,
                                  countries: state.previousCountries,
                                  states: state.previousStates,
                                  businessModels: state.previousBusinessModels,
                                  businessCategories: state.previousBusinessCategories,
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

                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import '../../../bloc/delegation_bloc_2.dart';
// import '../../../bloc/assigned_salesperson_bloc.dart';
// import '../widgets/current_config_widget.dart';

// class AdminDelegationScreen extends StatelessWidget {
//   const AdminDelegationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text('Admin Delegation'),
//         ),
//       ),
//       body: MultiBlocProvider(
//         providers: [
//           BlocProvider<AssignedSalespersonBloc>(
//             create: (context) => AssignedSalespersonBloc()..add(InitialState()),
//           ),
//           BlocProvider<DelegationBloc>(
//             create: (context) => DelegationBloc(),
//           ),
//         ],
//         child: const DelegationPage(),
//       ),
//     );
//   }
// }

// class DelegationPage extends StatelessWidget {
//   const DelegationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AssignedSalespersonBloc, AssignedSalespersonState>(
//       builder: (context, userDataState) {
//         if (userDataState is DataNotLoaded){
//           return const Center(
//               child: CircularProgressIndicator(),
//             );
//         }
//         else if  (userDataState is DataLoaded){
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: BlocBuilder<DelegationBloc, DelegationState>(
//               builder: (context, state) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       DropdownButtonFormField<String>(
//                         decoration: const InputDecoration(
//                           labelText: 'Salesperson',
//                           border: OutlineInputBorder(),
//                         ),
//                         items: userDataState.salesPeopleNames
//                             .map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                         onChanged: (newValue) {
//                           // print(userDataState);
//                           int index = userDataState.salesPeopleNames.indexOf(newValue!);
//                           print("--------");
//                           print("uuid");
//                           print(userDataState.salesPeopleRef[index]);
//                           print("--------");
//                           context
//                               .read<DelegationBloc>()
//                               .add(LoadSalespersonDetails(newValue, userDataState.salesPeopleRef[index]));
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       const AccordionPage(),
//                       // Row(
//                       //   children: [
//                       //     Expanded(
//                       //       child: Text(
//                       //         'Country: ${state.previousCountries.join(', ')}',
//                       //         style: const TextStyle(fontSize: 16.0),
//                       //       ),
//                       //     ),
//                       //     const SizedBox(width: 16.0),
//                       //     Expanded(
//                       //       child: Text(
//                       //         'State: ${state.previousStates.join(', ')}',
//                       //         style: const TextStyle(fontSize: 16.0),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // const SizedBox(height: 16.0),
//                       // Row(
//                       //   children: [
//                       //     Expanded(
//                       //       child: Text(
//                       //         'Business Model: ${state.previousBusinessModels.join(', ')}',
//                       //         style: const TextStyle(fontSize: 16.0),
//                       //       ),
//                       //     ),
//                       //     const SizedBox(width: 16.0),
//                       //     Expanded(
//                       //       child: Text(
//                       //         'Business Category: ${state.previousBusinessCategories.join(', ')}',
//                       //         style: const TextStyle(fontSize: 16.0),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       const SizedBox(height: 16.0),
//                       const Text(
//                         "New delegations",
//                           style: TextStyle(
//                             fontSize: 24, // Set the font size to a heading size
//                             fontWeight: FontWeight.bold, // Make the text bold
//                           ),
//                           textAlign: TextAlign.left, 
//                       ),
//                       MultiSelectDialogField(
//                         // items: ['Country 1', 'Country 2', 'Country 3']
//                         //     .map((e) => MultiSelectItem<String>(e, e))
//                         //     .toList(),
//                         items: userDataState.countries.map((item) => item['name']).toList()
//                             .map((e) => MultiSelectItem<String>(e, e))
//                             .toList(),
//                         title: const Text("Edit Country"),
//                         selectedColor: Colors.green,
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(30)),
//                           border: Border.all(
//                             color: Colors.green,
//                             width: 2,
//                           ),
//                         ),
//                         buttonIcon: const Icon(
//                           Icons.arrow_drop_down,
//                           color: Colors.black,
//                         ),
//                         buttonText: const Text(
//                           "Select Countries",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                         ),
//                         onConfirm: (results) {
//                           // int index = state.salesPeopleNames.indexOf(newValue!);
//                           context.read<DelegationBloc>().add(UpdateDetails(
//                                 salesperson: state.selectedSalesperson,
//                                 salespersonRef: state.selectedSalespersonRef,
//                                 // countries: results.cast<String>(),
//                                 countries: results,
//                                 states: state.states,
//                                 businessModels: state.businessModels,
//                                 businessCategories: state.businessCategories,
//                               ));
//                         },
//                         initialValue: state.countries,
//                       ),
//                       const SizedBox(height: 16.0),
//                       MultiSelectDialogField(
//                         // items: ['State 1', 'State 2', 'State 3']
//                         //     .map((e) => MultiSelectItem<String>(e, e))
//                         //     .toList(),
//                           items: userDataState.states.map((item) => item['name']).toList()
//                             .map((e) => MultiSelectItem<String>(e, e))
//                             .toList(),
//                         title: const Text("Edit State"),
//                         selectedColor: Colors.green,
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(30)),
//                           border: Border.all(
//                             color: Colors.green,
//                             width: 2,
//                           ),
//                         ),
//                         buttonIcon: const Icon(
//                           Icons.arrow_drop_down,
//                           color: Colors.black,
//                         ),
//                         buttonText: const Text(
//                           "Select States",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                         ),
//                         onConfirm: (results) {
//                           context.read<DelegationBloc>().add(UpdateDetails(
//                                 salesperson: state.selectedSalesperson,
//                                 salespersonRef: state.selectedSalespersonRef,
//                                 countries: state.countries,
//                                 // states: results.cast<String>(),
//                                 states: results,
//                                 businessModels: state.businessModels,
//                                 businessCategories: state.businessCategories,
//                               ));
//                         },
//                         initialValue: state.states,
//                       ),
//                       const SizedBox(height: 16.0),
//                       MultiSelectDialogField(
//                         // items: ['Model 1', 'Model 2', 'Model 3']
//                         //     .map((e) => MultiSelectItem<String>(e, e))
//                         //     .toList(),
//                           items: userDataState.businessModels.map((item) => item['name']).toList()
//                             .map((e) => MultiSelectItem<String>(e, e))
//                             .toList(),
//                         title: const Text("Edit Business Model"),
//                         selectedColor: Colors.green,
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(30)),
//                           border: Border.all(
//                             color: Colors.green,
//                             width: 2,
//                           ),
//                         ),
//                         buttonIcon: const Icon(
//                           Icons.arrow_drop_down,
//                           color: Colors.black,
//                         ),
//                         buttonText: const Text(
//                           "Select Business Models",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                         ),
//                         onConfirm: (results) {
//                           context.read<DelegationBloc>().add(UpdateDetails(
//                                 salesperson: state.selectedSalesperson,
//                                 salespersonRef: state.selectedSalespersonRef,
//                                 countries: state.countries,
//                                 states: state.states,
//                                 businessModels: results,
//                                 // businessModels: results.cast<String>(),
//                                 businessCategories: state.businessCategories,
//                               ));
//                         },
//                         initialValue: state.businessModels,
//                       ),
//                       const SizedBox(height: 16.0),
//                       MultiSelectDialogField(
//                         // items: ['Category 1', 'Category 2', 'Category 3']
//                         //     .map((e) => MultiSelectItem<String>(e, e))
//                         //     .toList(),
//                           items: userDataState.categories.map((item) => item['name']).toList()
//                             .map((e) => MultiSelectItem<String>(e, e))
//                             .toList(),
//                         title: const Text("Edit Business Category"),
//                         selectedColor: Colors.green,
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(30)),
//                           border: Border.all(
//                             color: Colors.green,
//                             width: 2,
//                           ),
//                         ),
//                         buttonIcon: const Icon(
//                           Icons.arrow_drop_down,
//                           color: Colors.black,
//                         ),
//                         buttonText: const Text(
//                           "Select Business Categories",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                         ),
//                         onConfirm: (results) {
//                           context.read<DelegationBloc>().add(UpdateDetails(
//                                 salesperson: state.selectedSalesperson,
//                                 salespersonRef: state.selectedSalespersonRef,
//                                 countries: state.countries,
//                                 states: state.states,
//                                 businessModels: state.businessModels,
//                                 // businessCategories: results.cast<String>(),
//                                 businessCategories: results,
//                               ));
//                         },
//                         initialValue: state.businessCategories,
//                       ),
//                       const SizedBox(height: 16.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               context.read<DelegationBloc>().add(UpdateDetails(
//                                     salesperson: state.selectedSalesperson,
//                                     salespersonRef: state.selectedSalespersonRef,
//                                     countries: state.previousCountries,
//                                     states: state.previousStates,
//                                     businessModels: state.previousBusinessModels,
//                                     businessCategories:
//                                         state.previousBusinessCategories,
//                                   ));
//                             },
//                             child: const Text('Reset'),
//                           ),
//                           const SizedBox(width: 16.0),
//                           ElevatedButton(
//                             onPressed: () {
//                               context.read<DelegationBloc>().add(ApplyChanges());
//                             },
//                             child: const Text('Apply'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//         else{
//           return const Center(
//               child: CircularProgressIndicator(),
//             );
//         }
        
//       },
//     );
//   }
// }
