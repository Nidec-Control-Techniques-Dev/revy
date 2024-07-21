// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
// import '../../../bloc/get_params_bloc.dart';

// // Assuming GetParamsBloc and ApplyButtonPressed are defined elsewhere
// class ButtonApply extends StatelessWidget {
//   // final String filterStatus;
//   // final DateTime startDate;
//   // final DateTime endDate;

//   const ButtonApply({
//     Key? key,
//     // required this.startDate,
//     // required this.endDate,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GetParamsBloc, GetParamsState>(
//       builder: (context, state) {
//         return Center(
//           child: ElevatedButton(
//             onPressed: () {
//               context.read<ReadProgressBloc>().add(ApplyButtonPressed(
//                     // Replace `.filterStatus` with the actual value or variable
//                     filterStatus: state.filterStatus,
//                     startDate: state.startDate,
//                     endDate: state.endDate,
//                   ));
//               print('Apply button pressed');
//             },
//             child: const Text('Apply'),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
import '../../../bloc/get_params_bloc.dart';

class ButtonApply extends StatelessWidget {
  const ButtonApply({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetParamsBloc, GetParamsState>(
      builder: (context, state) {
        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              onPressed: () {
                print("start--------");
                print(state.filterStatus);
                print("end--------");
                if (state.filterStatus == "All"){
                  context.read<ReadProgressBloc>().add(ApplyButtonPressed(
                    filterStatus: ["visited", "ongoing", "unvisited"],
                    startDate: state.startDate,
                    endDate: state.endDate,
                  ));
                print('Apply button pressed');
                }
                else{
                  context.read<ReadProgressBloc>().add(ApplyButtonPressed(
                        filterStatus: [state.filterStatus.toLowerCase()],
                        startDate: state.startDate,
                        endDate: state.endDate,
                      ));
                  print('Apply button pressed');
                }

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                side: const BorderSide(
                    color: Color.fromARGB(
                        255, 8, 128, 28)), // Adds a dark green border
                elevation: 10, // Adds shadow
                shadowColor: Colors.grey[700], // Sets the shadow color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Apply',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        );
      },
    );
  }
}
