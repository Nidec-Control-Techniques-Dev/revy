import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientPage extends StatefulWidget {
  final String clientName;
  final String businessModel;
  final String address;
  final String annualSales;
  final String telephoneNumber;
  final String email;
  final String faxNo;
  final String status;

  const ClientPage({
    Key? key,
    required this.clientName,
    required this.businessModel,
    required this.address,
    required this.annualSales,
    required this.telephoneNumber,
    required this.email,
    required this.faxNo,
    required this.status,
  }) : super(key: key);

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String? status;

  @override
  void initState() {
    super.initState();
    status = widget.status.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Client Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(widget.clientName,
                    style: GoogleFonts.anton(
                        fontWeight: FontWeight.bold, fontSize: 30))),
            const SizedBox(height: 8),
            _customDropdown(status, 'status'),
            const SizedBox(height: 50),
            Text('Business Model: ${widget.businessModel}',
                style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 8),
            Text('Address: ${widget.address}',
                style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 8),
            Text('Annual Sales: ${widget.annualSales}',
                style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 8),
            Text('Telephone Number: ${widget.telephoneNumber}',
                style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 8),
            Text('Email: ${widget.email}',
                style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 8),
            Text('Fax No: ${widget.faxNo}',
                style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 8),
            Text('Category: ${widget.faxNo}',
                style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black)),
            const SizedBox(height: 150),
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width *
                  0.55, // 80% of screen width
              height: 40, // Fixed height
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Succesful'),
                        content:
                            Text('Status successfully changed from X to Y'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Dismiss the dialog
                            },
                          ),
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Dismiss the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  elevation: 5, // Shadow elevation
                  padding: EdgeInsets.all(15), // Adjust padding as needed
                ),
                child: const Text('Apply'),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _customDropdown(String? currentValue, String dropdownLabel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true,
            isExpanded: true,
            style: TextStyle(color: Colors.black, fontSize: 10),
            value: currentValue,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            onChanged: (String? newValue) {
              setState(() {
                status = newValue?.toLowerCase();
              });
            },
            items: ['oem', 'ict'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value.toLowerCase(),
                child: Center(
                    child: Text(value,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14))),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class ClientPage extends StatefulWidget {
//   // Change to StatefulWidget
//   final String clientName;
//   final String businessModel;
//   final String address;
//   final String annualSales;
//   final String telephoneNumber;
//   final String email;
//   final String faxNo;
//   final String status;

//   const ClientPage({
//     super.key,
//     required this.clientName,
//     required this.businessModel,
//     required this.address,
//     required this.annualSales,
//     required this.telephoneNumber,
//     required this.email,
//     required this.faxNo,
//     required this.status,
//   });

//   @override
//   _ClientPageState createState() => _ClientPageState();
// }

// class _ClientPageState extends State<ClientPage> {
//   String? _selectedStatus; // Variable to hold the selected status

//   @override
//   void initState() {
//     super.initState();
//     _selectedStatus = 'Unvisited'; // Set default status to Unvisited
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Client Details')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Client Name: ${widget.clientName}',
//                 style: const TextStyle(color: Colors.black)),
//             const SizedBox(height: 8),
//             DropdownButton<String>(
//               value: _selectedStatus, // Current selected status
//               items: <String>[
//                 'Visited',
//                 'Ongoing',
//                 'Unvisited',
//               ].map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedStatus = newValue;
//                 });
//               },
//             ),
//             const SizedBox(height: 8),
//             Text('Business Model: ${widget.businessModel}',
//                 style: const TextStyle(color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Address: ${widget.address}',
//                 style: TextStyle(color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Annual Sales: ${widget.annualSales}',
//                 style: TextStyle(color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Telephone Number: ${widget.telephoneNumber}',
//                 style: TextStyle(color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Email: ${widget.email}',
//                 style: TextStyle(color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Fax No: ${widget.faxNo}',
//                 style: TextStyle(color: Colors.black)),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Done'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class ClientPage extends StatelessWidget {
//   final String clientName;
//   final String businessModel;
//   final String address;
//   final String annualSales;
//   final String telephoneNumber;
//   final String email;
//   final String faxNo;
//   final String status;

//   const ClientPage({
//     super.key,
//     required this.clientName,
//     required this.businessModel,
//     required this.address,
//     required this.annualSales,
//     required this.telephoneNumber,
//     required this.email,
//     required this.faxNo,
//     required this.status,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Client Details')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0), // Add some padding around the content
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
//           children: [
//             Text('Client Name: $clientName',
//                 style: const TextStyle(color: Colors.black)),
//             Text('Client Name: $status',
//                 style: const TextStyle(color: Colors.black)),
//             const SizedBox(height: 8), // Add some space between elements
//             Text('Business Model: $businessModel',
//                 style: const TextStyle(color: Colors.black)),
//             const SizedBox(height: 8), // Add some space between elements
//             Text('Address: $address', style: TextStyle(color: Colors.black)),
//             SizedBox(height: 8), // Add some space between elements
//             Text('Annual Sales: $annualSales',
//                 style: TextStyle(color: Colors.black)),
//             SizedBox(height: 8), // Add some space between elements
//             Text('Telephone Number: $telephoneNumber',
//                 style: TextStyle(color: Colors.black)),
//             SizedBox(height: 8), // Add some space between elements
//             Text('Email: $email', style: TextStyle(color: Colors.black)),
//             SizedBox(height: 8), // Add some space between elements
//             Text('Fax No: $faxNo', style: TextStyle(color: Colors.black)),
//             SizedBox(height: 8), // Add some space between elements
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the current page
//               },
//               child: Text('Done'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ClientPage extends StatelessWidget {
//   final String clientName;
//   final String businessModel;
//   final String address;
//   final String annualSales;
//   final String telephoneNumber;
//   final String email;
//   final String faxNo; // Simplified parameter
//   const ClientPage({
//     super.key,
//     required this.clientName,
//     required this.businessModel,
//     required this.address,
//     required this.annualSales,
//     required this.telephoneNumber,
//     required this.email,
//     required this.faxNo,
//   });

//   @override
//   Widget build(BuildContext context) {
//       return Scaffold(
//           body: Column(
//         children: [
//           Text('Client Name: ${businessModel}',
//               style: TextStyle(color: Colors.black)),
//           Text('Business Model: ${clientName}',
//               style: TextStyle(color: Colors.black)),
//           Text(
//             'Address: ${address}',
//             style: TextStyle(color: Colors.black),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Done'),
//           ),
//         ],
//       ));
//     };
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         // Using SingleChildScrollView for better scrolling experience
//         child: Column(
//           children: [
//             BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
//               builder: (context, state) {
//                 if (state is DataError) {
//                   return Center(child: Text('Error: ${state.message}'));
//                 }
//                 return Center(
//                   child: Text(clientName, style: const TextStyle(fontSize: 24)),
//                 );
//               },
//             ),
//             // Add other widgets here if needed
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ClientPage extends StatefulWidget {
//   final String clientName;
//   // final String businessModel;
//   // final String address;
//   // final String annualSales;
//   // final String telephoneNumber;
//   // final String email;
//   // final String faxNo; // Simplified parameter

//   const ClientPage({super.key, required this.clientName});

//   @override
//   State<ClientPage> createState() => _ClientPageState();
// }

// class _ClientPageState extends State<ClientPage> {
//   String selectedStatus = 'Ongoing';
//   List<String> statusOptions = ['Visited', 'Ongoing', 'Unvisited'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.clientName,
//             style: GoogleFonts.rubik(fontSize: 28, color: Colors.black)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start, // Start alignment for the list
//           children: [
//             SizedBox(height: 20),
//             Center(
//               // Center the DropdownButton
//               child: DropdownButton<String>(
//                 value: selectedStatus,
//                 icon: Icon(Icons.arrow_downward),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedStatus = newValue!;
//                   });
//                 },
//                 items:
//                     statusOptions.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//             ),
//             SizedBox(height: 40), // Space for better separation
//             Column(
//               crossAxisAlignment: CrossAxisAlignment
//                   .start, // Keep the list aligned to the start
//               children: [
//                 Text(
//                   'Business Model: ${widget.clientName}',
//                   style: const TextStyle(
//                       fontSize: 25, fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   'Address: ${widget.clientName}',
//                   style: const TextStyle(
//                       fontSize: 25, fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   'Annual Sales: ${widget.clientName}',
//                   style: const TextStyle(
//                       fontSize: 25, fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   'Telephone Number: ${widget.clientName}',
//                   style: const TextStyle(
//                       fontSize: 25, fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   'Email: ${widget.clientName}',
//                   style: const TextStyle(
//                       fontSize: 25, fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   'Fax Number: ${widget.clientName}',
//                   style: const TextStyle(
//                       fontSize: 25, fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20), // Additional space before the button
//             Center(
//               // Center the ElevatedButton
//               child: ElevatedButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text('Action Taken'),
//                         content: Text('The selected status has been saved.'),
//                         actions: <Widget>[
//                           TextButton(
//                             child: Text('OK'),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: Text('Done'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ClientPage extends StatefulWidget {
//   final int clientIndex;
//   final List<String> clientInfo;
//   final List<String> clientNames;

//   const ClientPage(
//       {Key? key,
//       required this.clientIndex,
//       required this.clientInfo,
//       required this.clientNames})
//       : super(key: key);

//   @override
//   State<ClientPage> createState() => _ClientPageState();
// }

// class _ClientPageState extends State<ClientPage> {
//   String dropdownValue = 'Ongoing';
//   List<String> listItem = ['Visited', 'Ongoing', 'Unvisited'];
//   // List<String> clientNames = [
//   //   'Client 1',
//   //   'Client 2',
//   //   'Client 3'
//   // ]; // Example client names
//   // List<String> clientInfo = [
//   //   'Description: Lorem ipsum dolor sit amet.',
//   //   'Address: 123 Main St, Anytown, USA',
//   //   'Category: Electronics',
//   //   'Sales: 100M'
//   // ]; // Static for now

//   @override
//   Widget build(BuildContext context) {
//     // Validate clientIndex to prevent out-of-range errors

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.clientNames[widget.clientIndex]}',
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
//             ...widget.clientInfo.sublist(widget.clientIndex).map((info) {
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