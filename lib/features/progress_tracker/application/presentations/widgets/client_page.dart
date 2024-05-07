import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String dropdownValue = 'Ongoing';
  List listItem = [
    'Visited', 'Ongoing', 'Unvisited'
  ];

  List<String> clientInfo = ['Description: Lorem','Address: Ipsum','Category: Dolor','Sales: Vatican'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Client 1', style: GoogleFonts.rubik(
                fontSize: 28,
                color: Colors.black
              ),)),
      body: 
      Column(
        children: [
          SizedBox(height:20),
          Container(alignment: Alignment.center,
          width:300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Set the border radius
              border: Border.all(color: Colors.grey), // Set border color
            ),
            child: DropdownButton(
              value: dropdownValue,
              onChanged: (newValue) {
                setState(() { 
                  dropdownValue = newValue.toString();
                });
              },
              style: GoogleFonts.rubik(
                fontSize: 28,
                color: Colors.black
              ),
              items: listItem.map((valueItem) {
                return DropdownMenuItem(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }
              ).toList(),
            ),
          ),
          SizedBox(height:10),
          ...clientInfo.map((info) {
            return Column(children: [Center(child: 
            Text(
              info
            ),), SizedBox(height:10)]);
          }

          ).toList(),
          Center(
            child: Container(
              width:300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 1, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the value for desired roundness
                      
                    ),
                    backgroundColor: Color.fromARGB(255, 255, 253, 246),
                  ),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ClientList()),); // sa main.dart dapat babalik
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    
                  ),
                ),
              ),
            ),
    
        ],
      )
    );  
  }
}