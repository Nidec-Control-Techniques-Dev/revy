import 'package:analytics/filter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'client_page.dart';
import 'package:google_fonts/google_fonts.dart';


class Client {
  final String name;
  final String description;
  final String address;
  final String category;
  final String sales;

  Client({
    required this.name,
    required this.description,
    required this.address,
    required this.category,
    required this.sales,
  });
}


class ClientListCompany1 extends StatelessWidget {
  final List<Client> clients = [
    Client(name: 'Client 1', description: 'Description 1', address: 'Address 1', category: 'Category 1', sales: 'Sales 1'),
    Client(name: 'Client 2', description: 'Description 2', address: 'Address 2', category: 'Category 2', sales: 'Sales 2'),
    Client(name: 'Client 5', description: 'Description 5', address: 'Address 5', category: 'Category 5', sales: 'Sales 5'),
    Client(name: 'Client 13', description: 'Description 13', address: 'Address 13', category: 'Category 13', sales: 'Sales 13'),
    Client(name: 'Client 29', description: 'Description 29', address: 'Address 29', category: 'Category 29', sales: 'Sales 29'),
    Client(name: 'Client 100', description: 'Description 100', address: 'Address 100', category: 'Category 100', sales: 'Sales 100'),

  ];

  ClientListCompany1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        List<Client> filteredList = clients;
        if (state.selectedFilter1 == 'Company 1' && state.selectedFilter2 != 'Choose a Filter') {
          if (state.selectedFilter2 == 'Today') {
            filteredList = clients.where((client) => client.name == 'Client 1' || client.name == 'Client 2').toList();
          } else if (state.selectedFilter2 == 'Last 7 Days') {
            filteredList = clients.where((client) => ['Client 1', 'Client 2', 'Client 5'].contains(client.name)).toList();
          } else if (state.selectedFilter2 == 'Last 30 Days') {
            filteredList = clients.where((client) => ['Client 1', 'Client 2', 'Client 5', 'Client 13', 'Client 29', 'Client 100'].contains(client.name)).toList();
          } else if (state.selectedFilter2 == 'All') {
            filteredList = clients;
          }
        }
        return ListView(
          children: [
            Container(
              height: 60.0,
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 3,
                child: Text(
                  "Client List",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(),
            ...filteredList.map((client) {
              return Column(children: [
                ListTile(
                  title: Transform.scale(
                    scale: 1,
                    child: Text(
                      client.name,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Transform.scale(
                    scale: 1,
                    child: Text(
                      client.description,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Transform.scale(
                        scale: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                          child: Icon(Icons.circle),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.5,
                        child: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientPage(
                          clientName: client.name,
                          clientInfo: [
                            'Description: ${client.description}',
                            'Address: ${client.address}',
                            'Category: ${client.category}',
                            'Sales: ${client.sales}'
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Divider()
              ]);
            }),
          ],
        );
      },
    );
  }
}


class ClientListCompany2 extends StatelessWidget {
  final List<Client> clients = [
    Client(name: 'Client 4', description: 'Description 4', address: 'Address 4', category: 'Category 4', sales: 'Sales 4'),
    Client(name: 'Client 5', description: 'Description 5', address: 'Address 5', category: 'Category 5', sales: 'Sales 5'),
    Client(name: 'Client 6', description: 'Description 6', address: 'Address 6', category: 'Category 6', sales: 'Sales 6'),
    Client(name: 'Client 7', description: 'Description 7', address: 'Address 7', category: 'Category 7', sales: 'Sales 7'),
    Client(name: 'Client 9', description: 'Description 9', address: 'Address 9', category: 'Category 9', sales: 'Sales 9'),
    Client(name: 'Client 23', description: 'Description 23', address: 'Address 23', category: 'Category 23', sales: 'Sales 23'),
    Client(name: 'Client 24', description: 'Description 24', address: 'Address 24', category: 'Category 24', sales: 'Sales 24'),
    Client(name: 'Client 87', description: 'Description 87', address: 'Address 87', category: 'Category 87', sales: 'Sales 87'),
    Client(name: 'Client 238', description: 'Description 238', address: 'Address 238', category: 'Category 238', sales: 'Sales 238'),
    Client(name: 'Client 788', description: 'Description 788', address: 'Address 788', category: 'Category 788', sales: 'Sales 788'),
  ];

  ClientListCompany2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        List<Client> filteredList = clients;
        if (state.selectedFilter1 == 'Company 2' && state.selectedFilter2 != 'Choose a Filter') {
          if (state.selectedFilter2 == 'Today') {
            filteredList = clients.where((client) => client.name == 'Client 4' || client.name == 'Client 5').toList();
          } else if (state.selectedFilter2 == 'Last 7 Days') {
            filteredList = clients.where((client) => ['Client 4', 'Client 5', 'Client 6', 'Client 7', 'Client 9'].contains(client.name)).toList();
          } else if (state.selectedFilter2 == 'Last 30 Days') {
            filteredList = clients.where((client) => ['Client 4','Client 5', 'Client 6', 'Client 7', 'Client 9', 'Client 23', 'Client 24', 'Client 87'].contains(client.name)).toList();
          } else if (state.selectedFilter2 == 'All') {
            filteredList = clients;
          }
        }
        return ListView(
          children: [
            Container(
              height: 60.0,
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 3,
                child: Text(
                  "Client List",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(),
            ...filteredList.map((client) {
              return Column(children: [
                ListTile(
                  title: Transform.scale(
                    scale: 1,
                    child: Text(
                      client.name,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Transform.scale(
                    scale: 1,
                    child: Text(
                      client.description,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Transform.scale(
                        scale: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                          child: Icon(Icons.circle),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.5,
                        child: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientPage(
                          clientName: client.name,
                          clientInfo: [
                            'Description: ${client.description}',
                            'Address: ${client.address}',
                            'Category: ${client.category}',
                            'Sales: ${client.sales}'
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Divider()
              ]);
            }),
          ],
        );
      },
    );
  }
}


class ClientListCompanyAll extends StatelessWidget {
  final List<Client> clients = [
    Client(name: 'Client 1', description: 'Description 1', address: 'Address 1', category: 'Category 1', sales: 'Sales 1'),
    Client(name: 'Client 2', description: 'Description 2', address: 'Address 2', category: 'Category 2', sales: 'Sales 2'),
    Client(name: 'Client 5', description: 'Description 5', address: 'Address 5', category: 'Category 5', sales: 'Sales 5'),
    Client(name: 'Client 13', description: 'Description 13', address: 'Address 13', category: 'Category 13', sales: 'Sales 13'),
    Client(name: 'Client 29', description: 'Description 29', address: 'Address 29', category: 'Category 29', sales: 'Sales 29'),
    Client(name: 'Client 100', description: 'Description 100', address: 'Address 100', category: 'Category 100', sales: 'Sales 100'),
    Client(name: 'Client 4', description: 'Description 4', address: 'Address 4', category: 'Category 4', sales: 'Sales 4'),
    Client(name: 'Client 5', description: 'Description 5', address: 'Address 5', category: 'Category 5', sales: 'Sales 5'),
    Client(name: 'Client 6', description: 'Description 6', address: 'Address 6', category: 'Category 6', sales: 'Sales 6'),
    Client(name: 'Client 7', description: 'Description 7', address: 'Address 7', category: 'Category 7', sales: 'Sales 7'),
    Client(name: 'Client 9', description: 'Description 9', address: 'Address 9', category: 'Category 9', sales: 'Sales 9'),
    Client(name: 'Client 23', description: 'Description 23', address: 'Address 23', category: 'Category 23', sales: 'Sales 23'),
    Client(name: 'Client 24', description: 'Description 24', address: 'Address 24', category: 'Category 24', sales: 'Sales 24'),
    Client(name: 'Client 87', description: 'Description 87', address: 'Address 87', category: 'Category 87', sales: 'Sales 87'),
    Client(name: 'Client 238', description: 'Description 238', address: 'Address 238', category: 'Category 238', sales: 'Sales 238'),
    Client(name: 'Client 788', description: 'Description 788', address: 'Address 788', category: 'Category 788', sales: 'Sales 788'),
  ];

  ClientListCompanyAll({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        List<Client> filteredList = clients;
       
        if (state.selectedFilter1 == 'All' && state.selectedFilter2 != 'Choose a Filter') {
          if (state.selectedFilter2 == 'Today') {
            filteredList = clients.where((client) => ['Client 1', 'Client 2', 'Client 4', 'Client 5'].contains(client.name)).toList();
          } else if (state.selectedFilter2 == 'Last 7 Days') {
            filteredList = clients.where((client) => ['Client 1','Client 2', 'Client 3','Client 4','Client 5', 'Client 6', 'Client 7', 'Client 9'].contains(client.name)).toList();
          } else if (state.selectedFilter2 == 'Last 30 Days') {
            filteredList = clients.where((client) => ['Client 1', 'Client 2', 'Client 3', 'Client 5', 'Client 13', 'Client 4', 'Client 6', 'Client 7', 'Client 9', 'Client 23', 'Client 24', 'Client 87'].contains(client.name)).toList();
          } else if (state.selectedFilter2 == 'All') {
            filteredList = clients;
          }
        }
        return ListView(
          children: [
            Container(
              height: 60.0,
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 3,
                child: Text(
                  "Client List",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(),
            ...filteredList.map((client) {
              return Column(children: [
                ListTile(
                  title: Transform.scale(
                    scale: 1,
                    child: Text(
                      client.name,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Transform.scale(
                    scale: 1,
                    child: Text(
                      client.description,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Transform.scale(
                        scale: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                          child: Icon(Icons.circle),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.5,
                        child: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientPage(
                          clientName: client.name,
                          clientInfo: [
                            'Description: ${client.description}',
                            'Address: ${client.address}',
                            'Category: ${client.category}',
                            'Sales: ${client.sales}'
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Divider()
              ]);
            }),
          ],
        );
      },
    );
  }
}

