import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/presentation/widgets/client_page.dart';
import 'client_page.dart';
import 'package:revy/features/admin_analytics/bloc/filter_bloc.dart';
// import '../widgets/client_list_legend.dart';
class ClientList extends StatelessWidget {
  const ClientList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Client Names',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          // LegendRow()
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.clientName?.length ?? 0,
                        itemBuilder: (context, index) {
                          final clients = state.clientName![index];
                          Color iconColor = Colors.grey;

                          if (state.status != null) {
                            switch (state.status![index]) {
                              case 'visited':
                                iconColor = Colors.green;
                                break;
                              case 'ongoing':
                                iconColor = Colors.yellow;
                                break;
                              case 'unvisited':
                                iconColor = Colors.red;
                                break;
                            }
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientPage(
                                    clientName: state.clientName![index],
                                    companyRef: state.companyRef![index],
                                    businessModel: state.businessModel![index],
                                    address: state.address![index],
                                    annualSales: state.annualSales![index].toDouble(),
                                    telephoneNumber: state.telephoneNumber![index],
                                    email: state.email![index],
                                    faxNo: state.faxNo![index],
                                    status: state.status![index],
                                    category: state.category![index],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: Icon(Icons.circle, color: iconColor),
                                title: Text(clients,
                                    style: const TextStyle(color: Colors.black)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
