import 'package:flutter/material.dart';
import 'client_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientList extends StatelessWidget {
  List<String> listItem = ['Client 1', 'Client 2', 'Client 3'];
  List<Color> iconColor = [
    Colors.green[700]!,
    Colors.red[700]!,
    Colors.yellow[700]!
  ];
  List<Color> iconBorderColor = [Colors.green, Colors.red, Colors.yellow];

  ClientList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 60.0,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 3, // Scale factor of 2.0
            child: Text(
              "Client List",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight
                    .bold, // or FontWeight.w700 for a bolder appearance
              ),
            ),
          ),
        ),
        const Divider(),
        ...listItem.asMap().entries.map((entry) {
          int idx = entry.key;
          String valueItem = entry.value;
          return Column(children: [
            ListTile(
                title: Transform.scale(
                  scale: 1,
                  child: Text(
                    valueItem,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight
                          .bold, // or FontWeight.w700 for a bolder appearance
                    ),
                  ),
                ),
                subtitle: Transform.scale(
                  scale: 1, // Scale factor of 2.0
                  child: Text(
                    valueItem,
                    style: GoogleFonts.roboto(
                        // or FontWeight.w700 for a bolder appearance
                        ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min, // Use min to fit the content
                  children: <Widget>[
                    Transform.scale(
                      scale:
                          0.5, // Scale down the icon to half its original size
                      child: Container(
                        decoration: BoxDecoration(
                          shape:
                              BoxShape.circle, // Makes the container circular
                          border: Border.all(
                            color: iconBorderColor[
                                idx], // Slightly darker shade of green
                            width: 2, // Border width
                          ),
                        ),
                        child: Icon(Icons.circle,
                            color: iconColor[idx]), // Active status icon
                      ),
                    ),
                    Transform.scale(
                      scale:
                          0.5, // Scale down the icon to half its original size
                      child: const Icon(
                          Icons.more_vert), // Another icon for example
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ClientPage()),
                  );
                }),
            const Divider()
          ]);
        }),
      ],
    );
  }
}
