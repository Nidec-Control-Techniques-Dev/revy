import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../../../bloc/client_config_bloc.dart'; // Assuming this is your BLoC setup
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import '../../../bloc/schedule_bloc.dart';
class AccordionPage extends StatefulWidget {
  final String? startLocation;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? chosenStates;
  final List<String>? chosenBusinessModels;
  final List<String>? chosenCategories;

  const AccordionPage({
    Key? key,
    this.startLocation,
    this.startDate,
    this.endDate,
    this.chosenStates,
    this.chosenBusinessModels,
    this.chosenCategories,
  }) : super(key: key);

  @override
  _AccordionPageState createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  static const contentStyle = TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);

  String getLoremIpsum() {
    return '''
    Start Location:  ${widget.startLocation?? ''}\n
    startDate: ${widget.startDate?? ''}\n
    endDate: ${widget.endDate?? ''}\n
    chosenStates: ${widget.chosenStates?? ''}\n
    chosenBusinessModels: ${widget.chosenBusinessModels?? ''}\n
    chosenCategories: ${widget.chosenCategories?? ''}\n
    ''';
  }

  String companies(String availableCompanies) {
    return '''
    ${availableCompanies}\n
    ''';
  }

  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(
      EmitSchedule(
        startDate: widget.startDate,
        endDate: widget.endDate,
        statesOptions: widget.chosenStates,
        businessModelsOptions : widget.chosenBusinessModels,
        categoriesOptions : widget.chosenCategories
      )
    );
  }

// || state is DataLoaded)
@override
Widget build(BuildContext context) {
  return BlocBuilder<ScheduleBloc, ScheduleState>(
    builder: (context, state) {
      if (state is ScheduleLoaded) { // Check for ScheduleLoaded state
        // Extract availableCompanies from the state
        // List<dynamic> availableCompanies = state.availableCompanies;
        return Accordion(
          children: [
            // AccordionSection(
            //   content: Text(getLoremIpsum(), style: contentStyle),
            //   header: const Text('Company Details', style: headerStyle),
            // ),
            AccordionSection(
              // Pass availableCompanies to the companies function
              
              content: Text(getLoremIpsum(), style: contentStyle),
              header: Text(companies(state.availableCompanies[0]), style: headerStyle),
            ),
            AccordionSection(
              // Pass availableCompanies to the companies function
              content: Text(state.companyAddresses[1], style: contentStyle),
              header:  Text(companies(state.availableCompanies[1]), style: headerStyle),
            ),
            AccordionSection(
              // Pass availableCompanies to the companies function
              content: Text(state.companyAddresses[2], style: contentStyle),
              header:  Text(companies(state.availableCompanies[2]), style: headerStyle),
            ),
            AccordionSection(
              // Pass availableCompanies to the companies function
              content: Text(state.companyAddresses[3], style: contentStyle),
              header:  Text(companies(state.availableCompanies[3]), style: headerStyle),
            ),
          ],
        );
      } else {
        return const Text('Error');
      }
    },
  );
}
}



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