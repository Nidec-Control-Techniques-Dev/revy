import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientPage extends StatefulWidget {
  final int clientIndex;
  final List<String> clientInfo;
  final List<String> clientNames;

  const ClientPage(
      {Key? key,
      required this.clientIndex,
      required this.clientInfo,
      required this.clientNames})
      : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String dropdownValue = 'Ongoing';
  List<String> listItem = ['Visited', 'Ongoing', 'Unvisited'];
  // List<String> clientNames = [
  //   'Client 1',
  //   'Client 2',
  //   'Client 3'
  // ]; // Example client names
  // List<String> clientInfo = [
  //   'Description: Lorem ipsum dolor sit amet.',
  //   'Address: 123 Main St, Anytown, USA',
  //   'Category: Electronics',
  //   'Sales: 100M'
  // ]; // Static for now

  @override
  Widget build(BuildContext context) {
    // Validate clientIndex to prevent out-of-range errors

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.clientNames[widget.clientIndex]}',
            style: GoogleFonts.rubik(
              fontSize: 28,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                style: GoogleFonts.rubik(
                  fontSize: 28,
                  color: Colors.black,
                ),
                items: listItem.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            ...widget.clientInfo.sublist(widget.clientIndex).map((info) {
              return Column(children: [
                Center(child: Text(info)),
                SizedBox(height: 10),
              ]);
            }).toList(),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 1, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color.fromARGB(255, 255, 253, 246),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ClientPage extends StatefulWidget {
//   final int clientIndex;

//   const ClientPage({Key? key, required this.clientIndex}) : super(key: key);

//   @override
//   State<ClientPage> createState() => _ClientPageState();
// }

// class _ClientPageState extends State<ClientPage> {
//   String dropdownValue = 'Ongoing';
//   List<String> listItem = ['Visited', 'Ongoing', 'Unvisited'];
//   List<String> clientNames = [
//     'Client 1',
//     'Client 2',
//     'Client 3'
//   ]; // Example client names
//   List<String> clientInfo = [
//     'Description: Lorem',
//     'Address: Ipsum',
//     'Category: Dolor',
//     'Sales: Vatican'
//   ]; // Static for now

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${clientNames[widget.clientIndex]}',
//             style: GoogleFonts.rubik(
//               fontSize: 28,
//               color: Colors.black,
//             )),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Container(
//               alignment: Alignment.center,
//               width: 300,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.grey),
//               ),
//               child: DropdownButton<String>(
//                 value: dropdownValue,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     dropdownValue = newValue!;
//                   });
//                 },
//                 style: GoogleFonts.rubik(
//                   fontSize: 28,
//                   color: Colors.black,
//                 ),
//                 items: listItem.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//             ),
//             SizedBox(height: 10),
//             ...clientInfo.map((info) {
//               return Column(children: [
//                 Center(child: Text(info)),
//                 SizedBox(height: 10),
//               ]);
//             }).toList(),
//             Center(
//               child: SizedBox(
//                 width: 300,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     side: BorderSide(width: 1, color: Colors.black),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     backgroundColor: Color.fromARGB(255, 255, 253, 246),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     "Done",
//                     style: TextStyle(fontSize: 24, color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }











// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ClientPage extends StatefulWidget {
//   const ClientPage({super.key});

//   @override
//   State<ClientPage> createState() => _ClientPageState();
// }

// class _ClientPageState extends State<ClientPage> {
//   String dropdownValue = 'Ongoing';
//   List listItem = [
//     'Visited', 'Ongoing', 'Unvisited'
//   ];

//   List<String> clientInfo = ['Description: Lorem','Address: Ipsum','Category: Dolor','Sales: Vatican'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Client 1', style: GoogleFonts.rubik(
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
//           ...clientInfo.map((info) {
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
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => ClientList()),); // sa main.dart dapat babalik
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