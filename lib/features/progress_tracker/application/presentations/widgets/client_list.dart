import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revy/features/progress_tracker/application/presentations/widgets/client_page.dart';
import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';

class ClientList extends StatelessWidget {
  const ClientList({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure ReadProgressBloc is available at this point in the widget tree
    // final readProgressBloc = BlocProvider.of<ReadProgressBloc>(context);

    return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
      builder: (context, state) {
        if (state is DataError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Client Names',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.clientName?.length ?? 0,
                        itemBuilder: (context, index) {
                          final clients =
                              // state.clientName![index]['name'];
                              state.clientName![index];
                              // state.clientName![index]['business_model_names'];
                          print("------");
                          print(clients);
                          print("------");
                          Color iconColor = Colors.grey;


                          print(state.clientName![index].runtimeType);
                          print(state.businessModel![index].runtimeType);
                          print(state.address![index].runtimeType);
                          print(state.annualSales![index].runtimeType);
                          print(state.telephoneNumber![index].runtimeType);
                          print(state.email![index].runtimeType);
                          print(state.faxNo![index].runtimeType);
                          print(state.status![index].runtimeType);
                          //

                          // if (businessModel != null) {
                          //   switch (businessModel.toLowerCase()) {
                          //     case 'oem':
                          //       iconColor = Colors.green;
                          //       break;
                          //     case 'ict':
                          //       iconColor = Colors.yellow;
                          //       break;
                          //     case 'cebu':
                          //     case 'laguna':
                          //     case 'pampanga':
                          //       iconColor = Colors.red;
                          //       break;
                          //   }
                          // }

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientPage(
                                    clientName: state.clientName![index],
                                    businessModel: state.businessModel![index],
                                    address: state.address![index],
                                    annualSales: state.annualSales![index],
                                    telephoneNumber: state.telephoneNumber![index],
                                    email: state.email![index],
                                    faxNo: state.faxNo![index],
                                    status: state.status![index]
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: Icon(Icons.circle, color: iconColor),
                                title: Text(clients,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/application/presentations/widgets/client_page.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';

// class ClientList extends StatelessWidget {
//   const ClientList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
//       builder: (context, state) {
//         if (state is DataError) {
//           return Center(child: Text('Error: ${state.message}'));
//         }
//         return Container(
//           padding: const EdgeInsets.all(25),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Client Names',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: state.clientName?.length ?? 0,
//                         itemBuilder: (context, index) {
//                           final clientName = state.clientName![index]['name'];

//                           Color iconColor = Colors.grey;

//                           if (clientName != null) {
//                             switch (clientName.toLowerCase()) {
//                               case 'metro manila':
//                                 iconColor = Colors.green;
//                                 break;
//                               case 'batangas':
//                                 iconColor = Colors.yellow;
//                                 break;
//                               case 'cebu':
//                               case 'laguna':
//                               case 'pampanga':
//                                 iconColor = Colors.red;
//                                 break;
//                             }
//                           }

//                           // Uncommented and modified onTap function
//                           // Inside the ListView.builder itemBuilder
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => BlocProvider.value(
//                                     value: BlocProvider.of<ReadProgressBloc>(
//                                         context),
//                                     child: ClientPage(),
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               margin: const EdgeInsets.symmetric(vertical: 8.0),
//                               child: ListTile(
//                                 leading: Icon(Icons.circle, color: iconColor),
//                                 title: Text(clientName,
//                                     style:
//                                         const TextStyle(color: Colors.black)),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }




// class ClientList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
//       builder: (context, state) {
//         if (state is DataError) {
//           return Center(child: Text('Error: ${state.message}'));
//         }
//         return Container(
//           padding: const EdgeInsets.all(25),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Client Names',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: state.clientName?.length ?? 0,
//                         itemBuilder: (context, index) {
//                           final clientName = state.clientName![index]['name'];
//                           Color iconColor = Colors.grey;

//                           if (clientName != null) {
//                             switch (clientName.toLowerCase()) {
//                               case 'metro manila':
//                                 iconColor = Colors.green;
//                                 break;
//                               case 'batangas':
//                                 iconColor = Colors.yellow;
//                                 break;
//                               case 'cebu':
//                                 iconColor = Colors.red;
//                                 break;
//                               case 'laguna':
//                                 iconColor = Colors.red;
//                                 break;
//                               case 'pampanga':
//                                 iconColor = Colors.red;
//                                 break;
//                             }
//                           }
//                           return Column(
//                             children: [
//                               Card(
//                                 margin:
//                                     const EdgeInsets.symmetric(vertical: 8.0),
//                                 child: ListTile(
//                                   leading: Icon(Icons.circle, color: iconColor),
//                                   title: Text(clientName,
//                                       style:
//                                           const TextStyle(color: Colors.black)),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

//WORKING
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
// // Adjust the path as needed

// class ClientList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Client List')),
//       body: BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
//         builder: (context, state) {
//           if (state is DataError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }

//           return Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(color: Colors.grey[200]),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: state.clientName?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       final clientName =
//                           state.clientName?[index]['name'] ?? 'Unknown';
//                       return ListTile(title: Text(clientName));
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: state.businessModel?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       final businessModel =
//                           state.businessModel?[index]['name'] ?? 'Unknown';
//                       return ListTile(title: Text(businessModel));
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../features/create_schedule/bloc/client_config_bloc.dart'; // Adjust the path as needed

// class ClientList extends StatelessWidget {
//   final List<Color> listBackgroundColors = [
//     Colors.red,
//     Colors.blue,
//     Colors.cyan,
//     Colors.green,
//     Colors.yellow,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(color: Colors.grey[200]),
//       child: BlocBuilder<DataBloc, DataState>(
//         builder: (context, state) {
//           if (state is DataInitial || state is DataLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is DataLoaded) {
//             int itemCount = state.statesOptions.length;
//             int groupsCount = 5; // Number of groups
//             int itemsPerGroup =
//                 itemCount ~/ groupsCount; // Calculate items per group
//             int remainingItems =
//                 itemCount % groupsCount; // Calculate remaining items

//             return Column(
//               children: List.generate(groupsCount, (groupIndex) {
//                 int start = groupIndex * itemsPerGroup +
//                     min(groupIndex, remainingItems);
//                 int end = start +
//                     itemsPerGroup +
//                     (groupIndex < remainingItems ? 1 : 0);

//                 return Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true, // Allow the list view to wrap its content
//                     physics:
//                         NeverScrollableScrollPhysics(), // Disable scrolling within each group
//                     itemCount: end - start,
//                     itemBuilder: (context, index) {
//                       final option = state.statesOptions[start + index];
//                       return Container(
//                         color: listBackgroundColors[
//                             groupIndex], // Apply different background color for each group
//                         child: ListTile(
//                             title: Text(option
//                                 .label), // Access the label property of the ValueItem
//                             tileColor: Colors
//                                 .white), // Optional: Set a background color for each list tile
//                       );
//                     },
//                   ),
//                 );
//               }),
//             );
//           } else {
//             return Center(child: Text('An error occurred'));
//           }
//         },
//       ),
//     );
//   }

//   // Helper function to find the minimum of two integers
//   int min(int a, int b) => a <= b ? a : b;
// }

// here is not the edited code
// class ClientList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(color: Colors.grey[200]),
//       child: BlocBuilder<DataBloc, DataState>(
//         builder: (context, state) {
//           if (state is DataInitial) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is DataLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is DataLoaded) {
//             // Assuming state.statesOptions contains the names of the states
//             return ListView.builder(
//               itemCount: state.statesOptions.length,
//               itemBuilder: (context, index) {
//                 final option = state.statesOptions[
//                     index]; // Assuming option is of type ValueItem
//                 return ListTile(
//                     title: Text(option
//                         .label)); // Access the label property of the ValueItem
//               },
//             );
//           } else {
//             return Center(child: Text('An error occurred'));
//           }
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
// import '../../../../../features/create_schedule/bloc/client_config_bloc.dart';
// import '../../../../../features/create_schedule/bloc/client_config_bloc.dart';

// class ClientList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             Text('Filter Status: ${state.filterStatus}'),
//             Text('Start Date: ${state.startDate.toString()}'),
//             Text('End Date: ${state.endDate.toString()}'),
//             // ElevatedButton(
//             //   onPressed: () {
//             //     context.read<ReadProgressBloc>().add(ApplyButtonPressed(
//             //           filterStatus: 'Completed',
//             //           startDate: DateTime.now().subtract(Duration(days: 7)),
//             //           endDate: DateTime.now(),
//             //         ));
//             //   },
//             //   child: Text('Update Filters'),
//             // ),
//           ],
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'client_page.dart'; // Ensure this import path matches where your ClientPage widget is located
// import 'package:google_fonts/google_fonts.dart';

// class ClientList extends StatelessWidget {
//   List<String> listItem = [
//     'Status',
//     'Ongoing',
//     'Client 3',
//     'Client 4',
//     'Client 5'
//   ];
//   List<String> clientInfo = [
//     'Info 1',
//     'Info 2',
//     'Info 3',
//     'Info 4',
//     'Info 5',
//   ];

//   final List<Color> iconColor = [
//     Colors.green[700]!,
//     Colors.red[700]!,
//     Colors.yellow[700]!
//   ];

//   final List<Color> iconBorderColor = [Colors.green, Colors.red, Colors.yellow];

//   ClientList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: listItem.length,
//       itemBuilder: (BuildContext context, int index) {
//         String clientName = listItem[index];
//         Color iconColorValue = iconColor[index % iconColor.length];
//         Color borderColor = iconBorderColor[index % iconBorderColor.length];

//         return Column(
//           children: [
//             ListTile(
//               title: Text(
//                 clientName,
//                 style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 clientName,
//                 style: GoogleFonts.roboto(),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: borderColor, width: 2),
//                     ),
//                     child: Icon(Icons.circle, color: iconColorValue),
//                   ),
//                   const Icon(Icons.more_vert),
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ClientPage(
//                             clientIndex: index,
//                             clientInfo: clientInfo,
//                             clientNames: listItem,
//                           )),
//                 );
//               },
//             ),
//             const Divider(),
//           ],
//         );
//       },
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';

// class ClientList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             Text('Filter Status: ${state.filterStatus}'),
//             Text('Start Date: ${state.startDate.toString()}'),
//             Text('End Date: ${state.endDate.toString()}'),
//             // ElevatedButton(
//             //   onPressed: () {
//             //     context.read<ReadProgressBloc>().add(ApplyButtonPressed(
//             //           filterStatus: 'Completed',
//             //           startDate: DateTime.now().subtract(Duration(days: 7)),
//             //           endDate: DateTime.now(),
//             //         ));
//             //   },
//             //   child: Text('Update Filters'),
//             // ),
//           ],
//         );
//       },
//     );
//   }
// }



//   Widget build(BuildContext context) {
//     // Check if listItem and clientInfo are not null before proceeding
//     if (listItem != null && clientInfo != null) {
//       return ListView.builder(
//         itemCount: listItem!.length,
//         itemBuilder: (BuildContext context, int index) {
//           String clientName = listItem![index];
//           Color iconColorValue = iconColor[index % iconColor.length];
//           Color borderColor = iconBorderColor[index % iconBorderColor.length];

//           return Column(
//             children: [
//               ListTile(
//                 title: Text(
//                   clientName,
//                   style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(
//                   clientName,
//                   style: GoogleFonts.roboto(),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: borderColor, width: 2),
//                       ),
//                       child: Icon(Icons.circle, color: iconColorValue),
//                     ),
//                     const Icon(Icons.more_vert),
//                   ],
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ClientPage(
//                               clientIndex: index,
//                               clientInfo: clientInfo!,
//                               clientNames: listItem!,
//                             )),
//                   );
//                 },
//               ),
//               const Divider(),
//             ],
//           );
//         },
//       );
//     } else {
//       // Return an empty container or some placeholder widget if listItem and clientInfo are null
//       return Container();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
// import 'client_page.dart'; // Ensure this import path matches where your ClientPage widget is located
// import 'package:google_fonts/google_fonts.dart';

// class ClientList extends StatelessWidget {
//   final List<String>? listItem;
//   final List<String>? clientInfo;

//   final List<Color> iconColor = [
//     Colors.green[700]!,
//     Colors.red[700]!,
//     Colors.yellow[700]!
//   ];

//   final List<Color> iconBorderColor = [Colors.green, Colors.red, Colors.yellow];

//   ClientList({
//     Key? key,
//     this.listItem,
//     this.clientInfo,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
//       builder: (context, state) {
//         return ListView.builder(
//           itemCount: listItem?.length ?? 0,
//           itemBuilder: (BuildContext context, int index) {
//             String clientName = listItem![index];
//             Color iconColorValue = iconColor[index % iconColor.length];
//             Color borderColor = iconBorderColor[index % iconBorderColor.length];

//             return Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     clientName,
//                     style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     clientName,
//                     style: GoogleFonts.roboto(),
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: borderColor, width: 2),
//                         ),
//                         child: Icon(Icons.circle, color: iconColorValue),
//                       ),
//                       const Icon(Icons.more_vert),
//                     ],
//                   ),
//                   // onTap: () {
//                   //   context.read<ReadProgressBloc>
//                   // },

//                   // onTap: () {
//                   //   Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //       builder: (context) => ClientPage(
//                   //         clientIndex: index,
//                   //         clientInfo: state.filterStatus,
//                   //         clientNames: state.startDate,

//                   //       ),
//                   //     ),
//                   //   );
//                   // },
//                 ),
//                 const Divider(),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'client_page.dart'; // Ensure this import path matches where your ClientPage widget is located
// import 'package:google_fonts/google_fonts.dart';

// class ClientList extends StatelessWidget {
//   List<String>? listItem;
//   List<String>? clientInfo;

//   final List<Color> iconColor = [
//     Colors.green[700]!,
//     Colors.red[700]!,
//     Colors.yellow[700]!
//   ];

//   final List<Color> iconBorderColor = [Colors.green, Colors.red, Colors.yellow];

//   ClientList({
//     Key? key,
//     this.listItem,
//     this.clientInfo,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Check if listItem and clientInfo are not null before using them
//     return ListView.builder(
//       itemCount: listItem?.length ?? 0,
//       itemBuilder: (BuildContext context, int index) {
//         String clientName =
//             listItem![index]; // Safe call since we checked for null above
//         Color iconColorValue = iconColor[index % iconColor.length];
//         Color borderColor = iconBorderColor[index % iconBorderColor.length];

//         return Column(
//           children: [
//             ListTile(
//               title: Text(
//                 clientName,
//                 style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 clientName,
//                 style: GoogleFonts.roboto(),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: borderColor, width: 2),
//                     ),
//                     child: Icon(Icons.circle, color: iconColorValue),
//                   ),
//                   const Icon(Icons.more_vert),
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ClientPage(
//                             clientIndex: index,
//                             clientInfo: clientInfo![
//                                 index], // Assuming ClientPage expects a single string for simplicity
//                             clientNames: listItem,
//                           )),
//                 );
//               },
//             ),
//             const Divider(),
//           ],
//         );
//       },
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'client_page.dart'; // Ensure this import path matches where your ClientPage widget is located
// import 'package:google_fonts/google_fonts.dart';

// class ClientList extends StatelessWidget {
//   final List<String> listItem = [
//     'Client 1',
//     'Client 2',
//     'Client 3',
//     'Client 4',
//     'Client 5'
//   ];

//   final List<Color> iconColor = [
//     Colors.green[700]!,
//     Colors.red[700]!,
//     Colors.yellow[700]!
//   ];

//   final List<Color> iconBorderColor = [Colors.green, Colors.red, Colors.yellow];

//   ClientList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: listItem.length,
//       itemBuilder: (BuildContext context, int index) {
//         String clientName = listItem[index];
//         Color iconColorValue = iconColor[index % iconColor.length];
//         Color borderColor = iconBorderColor[index % iconBorderColor.length];

//         return Column(
//           children: [
//             ListTile(
//               title: Text(
//                 clientName,
//                 style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 clientName,
//                 style: GoogleFonts.roboto(),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: borderColor, width: 2),
//                     ),
//                     child: Icon(Icons.circle, color: iconColorValue),
//                   ),
//                   const Icon(Icons.more_vert),
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ClientPage(clientIndex: index)),
//                 );
//               },
//             ),
//             const Divider(),
//           ],
//         );
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'client_page.dart'; // Ensure this import path matches where your ClientPage widget is located
// import 'package:google_fonts/google_fonts.dart';

// class ClientList extends StatelessWidget {
//   List<String> listItem = [
//     'Client 1',
//     'Client 2',
//     'Client 3',
//     'Client 4',
//     'Client 5'
//   ];
//   List<Color> iconColor = [
//     Colors.green[700]!,
//     Colors.red[700]!,
//     Colors.yellow[700]!
//   ];
//   List<Color> iconBorderColor = [Colors.green, Colors.red, Colors.yellow];

//   ClientList({Key? key}) : super(key: key); // Updated constructor

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         Container(
//           height: 60.0,
//           alignment: Alignment.center,
//           child: Transform.scale(
//             scale: 3,
//             child: Text(
//               "Client List",
//               style: GoogleFonts.rubik(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         const Divider(),
//         ...listItem.asMap().entries.map((entry) {
//           int idx = entry.key;
//           String valueItem = entry.value;
//           return Column(children: [
//             ListTile(
//               title: Transform.scale(
//                 scale: 1,
//                 child: Text(
//                   valueItem,
//                   style: GoogleFonts.roboto(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               subtitle: Transform.scale(
//                 scale: 1,
//                 child: Text(
//                   valueItem,
//                   style: GoogleFonts.roboto(),
//                 ),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Transform.scale(
//                     scale: 0.5,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: iconBorderColor[idx],
//                           width: 2,
//                         ),
//                       ),
//                       child: Icon(Icons.circle, color: iconColor[idx]),
//                     ),
//                   ),
//                   Transform.scale(
//                     scale: 0.5,
//                     child: const Icon(Icons.more_vert),
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 // Navigate to the next page and pass the index of the tapped item
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ClientPage(clientIndex: idx)),
//                 );
//               },
//             ),
//             const Divider()
//           ]);
//         }).toList(), // Convert Iterable to List to ensure proper rendering
//       ],
//     );
//   }
// }







