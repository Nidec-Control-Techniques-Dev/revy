import 'package:flutter/material.dart';
import 'client_page.dart'; // Ensure this import path matches where your ClientPage widget is located
import 'package:google_fonts/google_fonts.dart';

class ClientList extends StatelessWidget {
  List<String> listItem = [
    'Client 1',
    'Client 2',
    'Client 3',
    'Client 4',
    'Client 5'
  ];
  List<String> clientInfo = [
    'Info 1',
    'Info 2',
    'Info 3',
    'Info 4',
    'Info 5',
  ];

  final List<Color> iconColor = [
    Colors.green[700]!,
    Colors.red[700]!,
    Colors.yellow[700]!
  ];

  final List<Color> iconBorderColor = [Colors.green, Colors.red, Colors.yellow];

  ClientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listItem.length,
      itemBuilder: (BuildContext context, int index) {
        String clientName = listItem[index];
        Color iconColorValue = iconColor[index % iconColor.length];
        Color borderColor = iconBorderColor[index % iconBorderColor.length];

        return Column(
          children: [
            ListTile(
              title: Text(
                clientName,
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                clientName,
                style: GoogleFonts.roboto(),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor, width: 2),
                    ),
                    child: Icon(Icons.circle, color: iconColorValue),
                  ),
                  const Icon(Icons.more_vert),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientPage(
                            clientIndex: index,
                            clientInfo: clientInfo,
                            clientNames: listItem,
                          )),
                );
              },
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}







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







