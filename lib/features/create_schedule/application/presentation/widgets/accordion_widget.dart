import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accordion/accordion.dart';
import '../../../bloc/schedule_bloc.dart';

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
            return Accordion(
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
                        // TODO: reroute to report issue page
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:http/http.dart';
// import '../../../bloc/client_config_bloc.dart';
// import 'package:accordion/accordion.dart';
// // import 'package:accordion/controllers.dart';
// import '../../../bloc/schedule_bloc.dart';
// class AccordionPage extends StatefulWidget {
//   // final String? startLocation;
//   // final DateTime? startDate;
//   // final DateTime? endDate;
//   // final List<String>? chosenStates;
//   // final List<String>? chosenBusinessModels;
//   // final List<String>? chosenCategories;

//   const AccordionPage({
//     super.key,
//     // this.startLocation,
//     // this.startDate,
//     // this.endDate,
//     // this.chosenStates,
//     // this.chosenBusinessModels,
//     // this.chosenCategories,
//   });

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
//   }){
//     return '''
//     Business Model:  ${businessModel?? ''}\n
//     Category: ${category?? ''}\n
//     Subcategory: ${subcategory?? ''}\n
//     Address: ${address?? ''}\n
//     Annual Sales: ${annualSales?? ''}\n
//     Telephone Number: ${telephoneNumber?? ''}\n
//     Email: ${email?? ''}\n
//     Fax No: ${faxNo?? ''}\n
//     ''';
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // context.read<ScheduleBloc>().add(
//   //   //   EmitSchedule(
//   //   //     startLocation: widget.startLocation,
//   //   //     startDate: widget.startDate,
//   //   //     endDate: widget.endDate,
//   //   //     chosenStates: widget.chosenStates,
//   //   //     chosenBusinessModels : widget.chosenBusinessModels,
//   //   //     chosenCategories : widget.chosenCategories
//   //   //   )
//   //   // );
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     // Place your event-triggering logic here.
//   //     // For example, triggering an event in the bloc:
//   //     context.read<ScheduleBloc>().add(EmitSchedule(
//   //       startLocation: widget.startLocation,
//   //       startDate: widget.startDate,
//   //       endDate: widget.endDate,
//   //       chosenStates: widget.chosenStates,
//   //       chosenBusinessModels : widget.chosenBusinessModels,
//   //       chosenCategories : widget.chosenCategories
//   //     ));
//   //   });
//   // }

// // || state is DataLoaded)
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ScheduleBloc, ScheduleState>(
//       builder: (context, state) {
//         if (state is ScheduleLoaded) { // Check for ScheduleLoaded state
//           // Extract availableCompanies from the state
//           // List<dynamic> availableCompanies = state.availableCompanies;
//           return Accordion(
//             children: [
//               // AccordionSection(
//               //   content: Text(getLoremIpsum(), style: contentStyle),
//               //   header: const Text('Company Details', style: headerStyle),
//               // ),
//               AccordionSection(
//                 // Pass availableCompanies to the companies function
//                 content: Text(
//                   displayDetails(
//                     address: state.companyAddresses[0],
//                     annualSales: state.annualSales[0],
//                     businessModel: state.businessModel[0],
//                     category: state.categoryName[0],
//                     subcategory: state.subcategoryName[0],
//                     telephoneNumber: state.contactNumber[0],
//                     email: state.email[0],
//                     faxNo: state.faxNumber[0]
//                   ), 
//                   style: contentStyle
//                 ),
//                 header: Text(state.availableCompanies[0], style: headerStyle),
//               ),
//               AccordionSection(
//                 // Pass availableCompanies to the companies function
//                 content: Text(
//                   displayDetails(
//                     address: state.companyAddresses[1],
//                     annualSales: state.annualSales[1],
//                     businessModel: state.businessModel[1],
//                     category: state.categoryName[1],
//                     subcategory: state.subcategoryName[1],
//                     telephoneNumber: state.contactNumber[1],
//                     email: state.email[1],
//                     faxNo: state.faxNumber[1]
//                   ), 
//                   style: contentStyle
//                 ),
//                 header:  Text(state.availableCompanies[1], style: headerStyle),
//               ),
//               AccordionSection(
//                 // Pass availableCompanies to the companies function
//                 content: Text(
//                   displayDetails(
//                     address: state.companyAddresses[2],
//                     annualSales: state.annualSales[2],
//                     businessModel: state.businessModel[2],
//                     category: state.categoryName[2],
//                     subcategory: state.subcategoryName[2],
//                     telephoneNumber: state.contactNumber[2],
//                     email: state.email[2],
//                     faxNo: state.faxNumber[2]
//                   ), 
//                   style: contentStyle
//                 ),
//                 header:  Text(state.availableCompanies[2], style: headerStyle),
//               ),
//               AccordionSection(
//                 // Pass availableCompanies to the companies function
//                 content: Text(
//                   displayDetails(
//                     address: state.companyAddresses[3],
//                     annualSales: state.annualSales[3],
//                     businessModel: state.businessModel[3],
//                     category: state.categoryName[3],
//                     subcategory: state.subcategoryName[3],
//                     telephoneNumber: state.contactNumber[3],
//                     email: state.email[3],
//                     faxNo: state.faxNumber[3]
//                   ), 
//                   style: contentStyle
//                 ),
//                 header:  Text(state.availableCompanies[3], style: headerStyle),
//               ),
//             ],
//           );
//         } 
//         else {
//           return const Center(
//               child: CircularProgressIndicator(),
//             );
//         }
//       },
//     );
//   }
// }



// import 'package:accordion/accordion.dart';
// import 'package:accordion/controllers.dart';
// import 'package:flutter/material.dart';
// import '../../../bloc/client_config_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:get/get.dart';

// /// Main example page
// class AccordionPage extends StatelessWidget {
//   static const headerStyle = TextStyle(
//       color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
//   static const contentStyleHeader = TextStyle(
//       color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700);
//   static const contentStyle = TextStyle(
//       color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);

//   final String? startLocation;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final List<String>? chosenStates;
//   final List<String>? chosenBusinessModels;
//   final List<String>? chosenCategories;

//   static const loremIpsum = '''
//   Hello World
//   ''';

//   String getLoremIpsum() {
//     return '''
//     Start Location:  ${startLocation ?? 'Unknown'}\n
//     startDate: ${startDate ?? 'Unknown'}\n
//     endDate: ${endDate ?? 'Unknown'}\n
//     chosenStates: ${chosenStates ?? 'Unknown'}\n
//     chosenBusinessModels: ${chosenBusinessModels ?? 'Unknown'}\n
//     chosenCategories: ${chosenCategories ?? 'Unknown'}\n
//     ''';
//   }

//   const AccordionPage({
//     super.key,
//       this.startLocation,
//       this.startDate,
//       this.endDate,
//       this.chosenStates,
//       this.chosenBusinessModels,
//       this.chosenCategories

//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DataBloc, DataState>(
//       builder: (context, state) {
//         if (state is DataLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is DataLoaded) {
//           return Accordion(
//             // Your accordion configuration...
//             children: [
//               AccordionSection(
//                 // Configuration...
//                 content: Text(getLoremIpsum(), style: contentStyle),
//                 header: const Text('Company III', style: headerStyle),
//               ),
//               AccordionSection(
//                 // Configuration...
//                 content: Text(getLoremIpsum(), style: contentStyle),
//                 header: const Text('Company III', style: headerStyle),
//               )
//             ],
//           );
//         } else {
//           return const Text('Error');
//         }
//       },
//     );
//   }
// } //__

// import 'package:accordion/accordion.dart';
// import 'package:accordion/controllers.dart';
// import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// /// Main example page
// class AccordionPage extends StatelessWidget {
//   static const headerStyle = TextStyle(
//       color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
//   static const contentStyleHeader = TextStyle(
//       color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700);
//   static const contentStyle = TextStyle(
//       color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);

//   final String? startLocation;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final List<String>? chosenStates;
//   final List<String>? chosenBusinessModels;
//   final List<String>? chosenCategories;

//   static const loremIpsum = '''
//   Hello World
//   ''';

//   String getLoremIpsum() {
//     return '''
//     Start Location:  ${startLocation ?? 'Unknown'}\n
//     startDate: ${startDate ?? 'Unknown'}\n
//     endDate: ${endDate ?? 'Unknown'}\n
//     chosenStates: ${chosenStates ?? 'Unknown'}\n
//     chosenBusinessModels: ${chosenBusinessModels ?? 'Unknown'}\n
//     chosenCategories: ${chosenCategories ?? 'Unknown'}\n
//     ''';
//   }

//   const AccordionPage({
//     super.key,
//       this.startLocation,
//       this.startDate,
//       this.endDate,
//       this.chosenStates,
//       this.chosenBusinessModels,
//       this.chosenCategories

//   });

//   @override
//   build(context) => Accordion(
//           headerBorderColor: Colors.green,
//           headerBorderColorOpened: Colors.greenAccent,
//           // headerBorderWidth: 1,
//           headerBackgroundColorOpened: Colors.green,
//           contentBackgroundColor: Colors.white,
//           contentBorderColor: Colors.green,
//           contentBorderWidth: 3,
//           contentHorizontalPadding: 20,
//           scaleWhenAnimating: true,
//           openAndCloseAnimation: true,
//           headerPadding:
//               const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//           sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
//           sectionClosingHapticFeedback: SectionHapticFeedback.light,
//           children: [
//             AccordionSection(
//               isOpen: true,
//               contentVerticalPadding: 20,
//               leftIcon:
//                   const Icon(Icons.business_center_rounded, color: Colors.white),
//               header: const Text('Company I', style: headerStyle),
//               content: Text(getLoremIpsum(), style: contentStyle),
//             ),
//             AccordionSection(
//               isOpen: true,
//               contentVerticalPadding: 20,
//               leftIcon:
//                   const Icon(Icons.business_center_rounded, color: Colors.white),
//               header: const Text('Company II', style: headerStyle),
//               content: const Text(loremIpsum, style: contentStyle),
//             ),
//             AccordionSection(
//               isOpen: true,
//               contentVerticalPadding: 20,
//               leftIcon:
//                   const Icon(Icons.business_center_rounded, color: Colors.white),
//               header: const Text('Company III', style: headerStyle),
//               content: const Text(loremIpsum, style: contentStyle),
//             ),
//             AccordionSection(
//               isOpen: true,
//               contentVerticalPadding: 20,
//               leftIcon:
//                   const Icon(Icons.business_center_rounded, color: Colors.white),
//               header: const Text('Company IV', style: headerStyle),
//               content: const Text(loremIpsum, style: contentStyle),
//             ),
//           ],
//         );
// } //__

// class MyInputForm extends StatelessWidget //__
// {
//   const MyInputForm({super.key});

//   @override
//   Widget build(context) //__
//   {
//     return Column(
//       children: [
//         TextFormField(
//           decoration: InputDecoration(
//             label: const Text('Some text goes here ...'),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ).marginOnly(bottom: 10),
//         ElevatedButton(
//           onPressed: () {},
//           child: const Text('Submit'),
//         )
//       ],
//     );
//   }
// }

// class MyDataTable extends StatelessWidget //__
// {
//   const MyDataTable({super.key});

//   @override
//   Widget build(context) //__
//   {
//     return DataTable(
//       sortAscending: true,
//       sortColumnIndex: 1,
//       showBottomBorder: false,
//       columns: const [
//         DataColumn(
//             label: Text('ID', style: AccordionPage.contentStyleHeader),
//             numeric: true),
//         DataColumn(
//             label:
//                 Text('Description', style: AccordionPage.contentStyleHeader)),
//         DataColumn(
//             label: Text('Price', style: AccordionPage.contentStyleHeader),
//             numeric: true),
//       ],
//       rows: const [
//         DataRow(
//           cells: [
//             DataCell(Text('1',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right)),
//             DataCell(Text('Fancy Product', style: AccordionPage.contentStyle)),
//             DataCell(Text(r'$ 199.99',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right))
//           ],
//         ),
//         DataRow(
//           cells: [
//             DataCell(Text('2',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right)),
//             DataCell(
//                 Text('Another Product', style: AccordionPage.contentStyle)),
//             DataCell(Text(r'$ 79.00',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right))
//           ],
//         ),
//         DataRow(
//           cells: [
//             DataCell(Text('3',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right)),
//             DataCell(
//                 Text('Really Cool Stuff', style: AccordionPage.contentStyle)),
//             DataCell(Text(r'$ 9.99',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right))
//           ],
//         ),
//         DataRow(
//           cells: [
//             DataCell(Text('4',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right)),
//             DataCell(Text('Last Product goes here',
//                 style: AccordionPage.contentStyle)),
//             DataCell(Text(r'$ 19.99',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right))
//           ],
//         ),
//       ],
//     );
//   }
// }

// class MyNestedAccordion extends StatelessWidget //__
// {
//   const MyNestedAccordion({super.key});

//   @override
//   Widget build(context) //__
//   {
//     return Accordion(
//       paddingListTop: 0,
//       paddingListBottom: 0,
//       maxOpenSections: 1,
//       headerBackgroundColorOpened: Colors.black54,
//       headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//       children: [
//         AccordionSection(
//           isOpen: true,
//           leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
//           headerBackgroundColor: Colors.black38,
//           headerBackgroundColorOpened: Colors.black54,
//           header:
//               const Text('Nested Section #1', style: AccordionPage.headerStyle),
//           content: const Text(AccordionPage.loremIpsum,
//               style: AccordionPage.contentStyle),
//           contentHorizontalPadding: 20,
//           contentBorderColor: Colors.black54,
//         ),
//         AccordionSection(
//           isOpen: true,
//           leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//           header:
//               const Text('Nested Section #2', style: AccordionPage.headerStyle),
//           headerBackgroundColor: Colors.black38,
//           headerBackgroundColorOpened: Colors.black54,
//           contentBorderColor: Colors.black54,
//           content: const Row(
//             children: [
//               Icon(Icons.compare_rounded,
//                   size: 120, color: Colors.orangeAccent),
//               Flexible(
//                   flex: 1,
//                   child: Text(AccordionPage.loremIpsum,
//                       style: AccordionPage.contentStyle)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }