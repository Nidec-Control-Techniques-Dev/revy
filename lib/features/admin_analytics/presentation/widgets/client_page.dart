import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientPage extends StatefulWidget {
  final String? clientName;
  final String? companyRef;
  final List<dynamic>? businessModel;
  final List<dynamic>? category;
  final String? address;
  final double? annualSales;
  final String? telephoneNumber;
  final String? email;
  final String? faxNo;
  final String? status;

  const ClientPage({
    super.key,
    this.clientName,
    this.companyRef,
    this.businessModel,
    this.category,
    this.address,
    this.annualSales,
    this.telephoneNumber,
    this.email,
    this.faxNo,
    this.status,
  });

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String? status;

  @override
  void initState() {
    super.initState();
    status = widget.status?.toLowerCase() ?? 'unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Client Details')),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(widget.clientName ?? 'Unknown Client',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ))),
              const SizedBox(height: 8),
              const SizedBox(height: 50),
              Text(
                'Status: $status',
                style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
              const SizedBox(height: 8),
              Text(
                  'Business Model: ${widget.businessModel?.join(', ') ?? 'N/A'}',
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(height: 8),
              Text('Address: ${widget.address ?? 'N/A'}',
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(height: 8),
              Text('Annual Sales: ${widget.annualSales?.toString() ?? 'N/A'}',
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(height: 8),
              Text('Telephone Number: ${widget.telephoneNumber ?? 'N/A'}',
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(height: 8),
              Text('Email: ${widget.email ?? 'N/A'}',
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(height: 8),
              Text('Fax No: ${widget.faxNo ?? 'N/A'}',
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(height: 8),
              Text('Category: ${widget.category ?? 'N/A'}',
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customDropdown(String? currentValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true,
            isExpanded: true,
            style: const TextStyle(color: Colors.black, fontSize: 10),
            value: currentValue,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            onChanged: (String? newValue) {
              setState(() {
                status = newValue?.toLowerCase();
                print(status);
              });
            },
            items: ['Visited', 'Ongoing', 'Unvisited']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value.toLowerCase(),
                child: Center(
                    child: Text(value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14))),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import '../../bloc/update_status_bloc.dart';
// // import '../../utils/update_status.dart';

// class ClientPage extends StatefulWidget {
//   final String? clientName;
//   final String? companyRef;
//   final List<dynamic>? businessModel;
//   final List<dynamic>? category;
//   final String? address;
//   final double? annualSales;
//   final String? telephoneNumber;
//   final String? email;
//   final String? faxNo;
//   final String? status;

//   const ClientPage({
//     super.key,
//     this.clientName,
//     this.companyRef,
//     this.businessModel,
//     this.category,
//     this.address,
//     this.annualSales,
//     this.telephoneNumber,
//     this.email,
//     this.faxNo,
//     this.status,
//   });

//   @override
//   _ClientPageState createState() => _ClientPageState();
// }

// class _ClientPageState extends State<ClientPage> {
//   String? status;

//   @override
//   void initState() {
//     super.initState();
//     status = widget.status?.toLowerCase() ?? 'unknown';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Client Details')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//                 child: Text(widget.clientName ?? 'Unknown Client',
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 30,
//                     ))),
//             const SizedBox(height: 8),
//             // _customDropdown(status),
//             const SizedBox(height: 50),
//             Text(
//               'Status: $status',
//               style: GoogleFonts.robotoSlab(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 18,
//                   color: Colors.black)),
//             const SizedBox(height: 8),
//             Text(
//                 'Business Model: ${widget.businessModel?.join(', ') ?? 'N/A'}',
//                 style: GoogleFonts.robotoSlab(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Address: ${widget.address ?? 'N/A'}',
//                 style: GoogleFonts.robotoSlab(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Annual Sales: ${widget.annualSales?.toString() ?? 'N/A'}',
//                 style: GoogleFonts.robotoSlab(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Telephone Number: ${widget.telephoneNumber ?? 'N/A'}',
//                 style: GoogleFonts.robotoSlab(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Email: ${widget.email ?? 'N/A'}',
//                 style: GoogleFonts.robotoSlab(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Fax No: ${widget.faxNo ?? 'N/A'}',
//                 style: GoogleFonts.robotoSlab(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: Colors.black)),
//             const SizedBox(height: 8),
//             Text('Category: ${widget.category ?? 'N/A'}',
//                 style: GoogleFonts.robotoSlab(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                     color: Colors.black)),
//             const SizedBox(height: 150),
//             // Center(
//             //     child: Container(
//             //   width: MediaQuery.of(context).size.width *
//             //       0.55, // 80% of screen width
//             //   height: 40, // Fixed height
//             //   child: ElevatedButton(
//             //     onPressed: () {
//             //       // context.read<UpdateStatusBloc>().add(ApplyButtonPressed(
//             //       //       status: status,
//             //       //       companyRef: widget.companyRef,
//             //       //     ));
//             //       insertSchedule(status: status, companyRef: widget.companyRef);
//             //       showDialog(
//             //         context: context,
//             //         builder: (BuildContext context) {
//             //           return AlertDialog(
//             //             title: const Text('Successful'),
//             //             content: const Text(
//             //                 'Status successfully changed from X to Y'),
//             //             actions: <Widget>[
//             //               TextButton(
//             //                 child: const Text('Cancel'),
//             //                 onPressed: () {
//             //                   Navigator.of(context)
//             //                       .pop(); // Dismiss the dialog
//             //                 },
//             //               ),
//             //               TextButton(
//             //                 child: const Text('OK'),
//             //                 onPressed: () {
//             //                   Navigator.of(context)
//             //                       .pop(); // Dismiss the dialog
//             //                 },
//             //               ),
//             //             ],
//             //           );
//             //         },
//             //       );
//             //     },
//             //     style: ElevatedButton.styleFrom(
//             //       shape: RoundedRectangleBorder(
//             //         borderRadius:
//             //             BorderRadius.circular(30), // Rounded corners
//             //       ),
//             //       elevation: 5, // Shadow elevation
//             //       padding:
//             //           const EdgeInsets.all(15), // Adjust padding as needed
//             //     ),
//             //     child: const Text('Apply'),
//             //   ),
//             // )),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _customDropdown(String? currentValue) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: const Offset(0, 3))
//           ],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             isDense: true,
//             isExpanded: true,
//             style: const TextStyle(color: Colors.black, fontSize: 10),
//             value: currentValue,
//             icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
//             onChanged: (String? newValue) {
//               setState(() {
//                 status = newValue?.toLowerCase();
//                 print(status);
//                 // currentValue = newValue?.toLowerCase();
//                 // print(currentValue?.toLowerCase());
//               });
//             },
//             items: ['Visited', 'Ongoing', 'Unvisited']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value.toLowerCase(),
//                 child: Center(
//                     child: Text(value,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(fontSize: 14))),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
