// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ClientPage extends StatefulWidget {
//   final String clientName;
//   final List<String> clientInfo;

//   const ClientPage({super.key, required this.clientName, required this.clientInfo});

//   @override
//   State<ClientPage> createState() => _ClientPageState();
// }

// class _ClientPageState extends State<ClientPage> {
//   String dropdownValue = 'Ongoing';
//   List listItem = ['Visited', 'Ongoing', 'Unvisited'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.clientName, style: GoogleFonts.rubik(
//                 fontSize: 28,
//                 color: Colors.black
//               ),)),
//       body: 
//       Column(
//         children: [
//           const SizedBox(height:20),
//           Container(alignment: Alignment.center,
//           width:300,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20), // Set the border radius
//               border: Border.all(color: Colors.grey), // Set border color
//             ),
//             child: DropdownButton(
//               value: dropdownValue,
//               onChanged: (newValue) {
//                 setState(() { 
//                   dropdownValue = newValue.toString();
//                 });
//               },
//               style: GoogleFonts.rubik(
//                 fontSize: 28,
//                 color: Colors.black
//               ),
//               items: listItem.map((valueItem) {
//                 return DropdownMenuItem(
//                   value: valueItem,
//                   child: Text(valueItem),
//                 );
//               }
//               ).toList(),
//             ),
//           ),
//           const SizedBox(height:10),
//           ...widget.clientInfo.map((info) {
//             return Column(children: [Center(child: 
//             Text(
//               info
//             ),), const SizedBox(height:10)]);
//           }

//           ),
//           Center(
//             child: SizedBox(
//               width:300,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     side: const BorderSide(width: 1, color: Colors.black),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20), // Adjust the value for desired roundness
                      
//                     ),
//                     backgroundColor: const Color.fromARGB(255, 255, 253, 246),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text(
//                     "Done",
//                     style: TextStyle(fontSize: 24, color: Colors.black),
                    
//                   ),
//                 ),
//               ),
//             ),
    
//         ],
//       )
//     );  
//   }
// }
