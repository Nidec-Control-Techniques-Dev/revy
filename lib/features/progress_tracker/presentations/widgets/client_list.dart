import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revy/features/progress_tracker/presentations/widgets/client_page.dart';
import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
// import 'package:revy/features/progress_tracker/bloc/update_status_bloc.dart';

class ClientList extends StatelessWidget {
  const ClientList({super.key});

  @override
  Widget build(BuildContext context) {
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
                          final clients = state.clientName![index];
                          Color iconColor = Colors.grey;

                          if (state.status != null) {
                            switch (state.status![index]) {
                              case 'visited':
                                iconColor = Colors.green;
                                break;
                              case 'ongoing':
                                iconColor = Colors.yellow;
                                break;
                              case 'unvisited':
                                iconColor = Colors.red;
                                break;
                            }
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientPage(
                                    clientName: state.clientName![index],
                                    companyRef: state.companyRef![index],
                                    businessModel: state.businessModel![index],
                                    address: state.address![index],
                                    annualSales: state.annualSales![index],
                                    telephoneNumber: state.telephoneNumber![index],
                                    email: state.email![index],
                                    faxNo: state.faxNo![index],
                                    status: state.status![index],
                                    category: state.category![index],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: Icon(Icons.circle, color: iconColor),
                                title: Text(clients,
                                    style: const TextStyle(color: Colors.black)),
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
// import 'package:revy/features/progress_tracker/bloc/update_status_bloc.dart';

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
//                           final clients = state.clientName![index];
//                           Color iconColor = Colors.grey;

//                           if (state.status != null) {
//                             switch (state.status![index]) {
//                               case 'visited':
//                                 iconColor = Colors.green;
//                                 break;
//                               case 'ongoing':
//                                 iconColor = Colors.yellow;
//                                 break;
//                               case 'unvisited':
//                                 iconColor = Colors.red;
//                                 break;
//                             }
//                           }

//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => BlocProvider.value(
//                                     value: BlocProvider.of<UpdateStatusBloc>(context),
//                                     child: ClientPage(
//                                       clientName: state.clientName![index],
//                                       companyRef: state.companyRef![index],
//                                       businessModel: state.businessModel![index],
//                                       address: state.address![index],
//                                       annualSales: state.annualSales![index],
//                                       telephoneNumber: state.telephoneNumber![index],
//                                       email: state.email![index],
//                                       faxNo: state.faxNo![index],
//                                       status: state.status![index],
//                                       category: state.category![index],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               margin: const EdgeInsets.symmetric(vertical: 8.0),
//                               child: ListTile(
//                                 leading: Icon(Icons.circle, color: iconColor),
//                                 title: Text(clients,
//                                     style: const TextStyle(color: Colors.black)),
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
//                           final clients = state.clientName![index];
//                           Color iconColor = Colors.grey;

//                           if (state.status != null) {
//                             switch (state.status![index]) {
//                               case 'visited':
//                                 iconColor = Colors.green;
//                                 break;
//                               case 'ongoing':
//                                 iconColor = Colors.yellow;
//                                 break;
//                               case 'unvisited':
//                                 iconColor = Colors.red;
//                                 break;
//                             }
//                           }

//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ClientPage(
//                                     clientName: state.clientName![index],
//                                     companyRef: state.companyRef![index],
//                                     businessModel: state.businessModel![index],
//                                     address: state.address![index],
//                                     annualSales: state.annualSales![index],
//                                     telephoneNumber: state.telephoneNumber![index],
//                                     email: state.email![index],
//                                     faxNo: state.faxNo![index],
//                                     status: state.status![index],
//                                     category: state.category![index],
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               margin: const EdgeInsets.symmetric(vertical: 8.0),
//                               child: ListTile(
//                                 leading: Icon(Icons.circle, color: iconColor),
//                                 title: Text(clients,
//                                     style: const TextStyle(color: Colors.black)),
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/application/presentations/widgets/client_page.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
// import '../../../bloc/update_status_bloc.dart';

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
//                           final clients = state.clientName![index];
//                           Color iconColor = Colors.grey;

//                           if (state.status != null) {
//                             switch (state.status![index]) {
//                               case 'visited':
//                                 iconColor = Colors.green;
//                                 break;
//                               case 'ongoing':
//                                 iconColor = Colors.yellow;
//                                 break;
//                               case 'unvisited':
//                                 iconColor = Colors.red;
//                                 break;
//                             }
//                           }

//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => BlocProvider.value(
//                                     value: BlocProvider.of<UpdateStatusBloc>(context),
//                                     child: ClientPage(
//                                       clientName: state.clientName![index],
//                                       companyRef: state.companyRef![index],
//                                       businessModel: state.businessModel![index],
//                                       address: state.address![index],
//                                       annualSales: state.annualSales![index],
//                                       telephoneNumber: state.telephoneNumber![index],
//                                       email: state.email![index],
//                                       faxNo: state.faxNo![index],
//                                       status: state.status![index],
//                                       category: state.category![index],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               margin: const EdgeInsets.symmetric(vertical: 8.0),
//                               child: ListTile(
//                                 leading: Icon(Icons.circle, color: iconColor),
//                                 title: Text(clients,
//                                     style: const TextStyle(color: Colors.black)),
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/application/presentations/widgets/client_page.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
// import '../../../bloc/update_status_bloc.dart';

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
//                           final clients = state.clientName![index];
//                           Color iconColor = Colors.grey;

//                           if (state.status != null) {
//                             switch (state.status![index]) {
//                               case 'visited':
//                                 iconColor = Colors.green;
//                                 break;
//                               case 'ongoing':
//                                 iconColor = Colors.yellow;
//                                 break;
//                               case 'unvisited':
//                                 iconColor = Colors.red;
//                                 break;
//                             }
//                           }

//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => BlocProvider.value(
//                                     value: BlocProvider.of<UpdateStatusBloc>(context),
//                                     child: ClientPage(
//                                       clientName: state.clientName![index],
//                                       companyRef: state.companyRef![index],
//                                       businessModel: state.businessModel![index],
//                                       address: state.address![index],
//                                       annualSales: state.annualSales![index],
//                                       telephoneNumber: state.telephoneNumber![index],
//                                       email: state.email![index],
//                                       faxNo: state.faxNo![index],
//                                       status: state.status![index],
//                                       category: state.category![index],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               margin: const EdgeInsets.symmetric(vertical: 8.0),
//                               child: ListTile(
//                                 leading: Icon(Icons.circle, color: iconColor),
//                                 title: Text(clients,
//                                     style: const TextStyle(color: Colors.black)),
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
// // 