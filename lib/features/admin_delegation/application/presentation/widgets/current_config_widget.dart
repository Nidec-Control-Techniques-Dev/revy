import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accordion/accordion.dart';
import '../../../bloc/delegation_bloc_2.dart';

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
    List<dynamic>? country,
    List<dynamic>? state,
  }) {
    return '''
    Countries:  ${country ?? ''}\n
    States: ${state ?? ''}\n
    Business Models: ${businessModel ?? ''}\n
    Categories: ${category ?? ''}\n
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DelegationBloc, DelegationState>(
      builder: (context, state) {
        if (state.countries.isNotEmpty) {
          return Column(
            children: [
              Accordion(
                children: List.generate([""].length, (index) {
                  return AccordionSection(
                    content: Container(
                      padding: const EdgeInsets.all(16.0), // Add padding to increase size
                      constraints: const BoxConstraints(
                        minHeight: 500, // Set minimum height
                        minWidth: double.infinity, // Set minimum width to fill parent
                      ),
                      child: Text(
                        displayDetails(
                          businessModel: state.previousBusinessModels,
                          category: state.businessCategories,
                          country: state.previousCountries,
                          state: state.previousStates,
                        ),
                        style: contentStyle,
                      ),
                    ),
                    header: const Text("Current delegations", style: headerStyle),
                  );
                }),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:accordion/accordion.dart';
// import '../../../bloc/delegation_bloc_2.dart';

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
//     List<dynamic>? country,
//     List<dynamic>? state,
//   }) {
//     return '''
//     Business Model:  ${country ?? ''}\n
//     Category: ${state ?? ''}\n
//     Subcategory: ${businessModel ?? ''}\n
//     Address: ${category ?? ''}\n
//     ''';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DelegationBloc, DelegationState>(
//       builder: (context, state) {
//           if (state.countries.isNotEmpty){
//             return Accordion(
//               children: List.generate([""].length, (index) {
//                 return AccordionSection(
//                   content: Text(
//                     displayDetails(
//                       businessModel: state.previousBusinessModels,
//                       category: state.businessCategories,
//                       country: state.previousCountries,
//                       state: state.previousStates
//                     ),
//                     style: contentStyle,
//                   ),
//                   header: const Text("Current delegations", style: headerStyle),
//                 );
//               }),
//             );
//           }
//           else{
//             return const SizedBox.shrink();
//           }
//       },
//     );
//   }
// }

