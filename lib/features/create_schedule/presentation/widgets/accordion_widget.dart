// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:accordion/accordion.dart';
// import '../../bloc/schedule_bloc.dart';
// import '../widgets/map_step4.dart';

// class AccordionPage extends StatefulWidget {
//   const AccordionPage({super.key});

//   @override
//   _AccordionPageState createState() => _AccordionPageState();
// }

// class _AccordionPageState extends State<AccordionPage> {
//   static const headerStyle = TextStyle(
//       color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
//   static const contentStyle = TextStyle(
//       color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);

//   String displayDetails({
//     List<dynamic>? businessModel,
//     List<dynamic>? category,
//     List<dynamic>? subcategory,
//     String? address,
//     double? annualSales,
//     String? telephoneNumber,
//     String? email,
//     String? faxNo,
//   }) {
//     return '''
//     Business Model:  ${businessModel ?? ''}\n
//     Category: ${category ?? ''}\n
//     Subcategory: ${subcategory ?? ''}\n
//     Address: ${address ?? ''}\n
//     Annual Sales: ${annualSales ?? ''}\n
//     Telephone Number: ${telephoneNumber ?? ''}\n
//     Email: ${email ?? ''}\n
//     Fax No: ${faxNo ?? ''}\n
//     ''';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ScheduleBloc, ScheduleState>(
//       builder: (context, state) {
//         if (state is ScheduleLoaded) {
//           // Extract availableCompanies from the state
//           List<dynamic> availableCompanies = state.availableCompanies;
//           if (availableCompanies.isNotEmpty) {
//             return Accordion(
//               children: List.generate(availableCompanies.length, (index) {
//                 return AccordionSection(
//                   content: Column(
//                     children: [
//                       Text(
//                         displayDetails(
//                           address: state.companyAddresses[index],
//                           annualSales: state.annualSales[index].toDouble(),
//                           businessModel: state.businessModel[index],
//                           category: state.categoryName[index],
//                           subcategory: state.subcategoryName[index],
//                           telephoneNumber: state.contactNumber[index],
//                           email: state.email[index],
//                           faxNo: state.faxNumber[index],
//                         ),
//                         style: contentStyle,
//                       ),
//                       const SizedBox(height: 10),
//                       MapScreen(), // Add the MapScreen here
//                     ],
//                   ),
//                   header: Text(availableCompanies[index], style: headerStyle),
//                 );
//               }),
//             );
//           } else {
//             return AlertDialog(
//               title: const Text('No Clients Found'),
//               content: RichText(
//                 text: const TextSpan(
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: 
//                       '''Please try to generate another schedule with a different configuration.
//                       ''',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     TextSpan(
//                       text: 
//                       '''If the problem continues to persist, please report the issue.
//                       ''',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   child: const Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop(); 
//                   },
//                 ),
//                 TextButton(
//                   child: const Text('Report Issue'),
//                   onPressed: () {
//                   },
//                 ),
//               ],
//             );
//           }
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accordion/accordion.dart';
import '../../bloc/schedule_bloc.dart';
import '../widgets/map_step4.dart';

class AccordionPage extends StatefulWidget {
  const AccordionPage({super.key});

  @override
  _AccordionPageState createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  static const contentStyle = TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);

  String displayDetails({
    List<dynamic>? businessModel,
    List<dynamic>? category,
    List<dynamic>? subcategory,
    String? address,
    double? annualSales,
    String? telephoneNumber,
    String? email,
    String? faxNo,
  }) {
    return '''
    Business Model:  ${businessModel ?? ''}\n
    Category: ${category ?? ''}\n
    Subcategory: ${subcategory ?? ''}\n
    Address: ${address ?? ''}\n
    Annual Sales: ${annualSales ?? ''}\n
    Telephone Number: ${telephoneNumber ?? ''}\n
    Email: ${email ?? ''}\n
    Fax No: ${faxNo ?? ''}\n
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoaded) {
          // Extract availableCompanies from the state
          List<dynamic> availableCompanies = state.availableCompanies;
          if (availableCompanies.isNotEmpty){
            return Column(
              children: [
                SizedBox(
                  width: double.infinity, // Use the available width
                  height: 300,
                  child: MapScreen()
                ),
                Accordion(
                  children: List.generate(availableCompanies.length, (index) {
                    return AccordionSection(
                      content: Text(
                        displayDetails(
                          address: state.companyAddresses[index],
                          annualSales: state.annualSales[index].toDouble(),
                          businessModel: state.businessModel[index],
                          category: state.categoryName[index],
                          subcategory: state.subcategoryName[index],
                          telephoneNumber: state.contactNumber[index],
                          email: state.email[index],
                          faxNo: state.faxNumber[index],
                        ),
                        style: contentStyle,
                      ),
                      header: Text(availableCompanies[index], style: headerStyle),
                    );
                  }),
                ),
              ],
            );
          }
          else{
                return AlertDialog(
                  title: const Text('No Clients Found'),
                  content: RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 
                          '''Please try to generate another schedule with a different configuration.
                          ''',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 
                          '''If the problem continues to persist, please report the issue.
                          ''',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                    ),
                    TextButton(
                      child: const Text('Report Issue'),
                      onPressed: () {
                      },
                ),
                  ],
                );
          }

        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

