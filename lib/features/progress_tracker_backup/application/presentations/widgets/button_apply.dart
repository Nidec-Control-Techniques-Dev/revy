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
            // Wrap the button in a container to control its size
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // Add some horizontal padding
            width: MediaQuery.of(context).size.width *
                0.8, // Set the width to 80% of the screen width
            child: ElevatedButton(
              onPressed: () {
                context.read<ReadProgressBloc>().add(ApplyButtonPressed(
                      // Replace `.filterStatus` with the actual value or variable
                      filterStatus: state.filterStatus,
                      startDate: state.startDate,
                      endDate: state.endDate,
                    ));
                print('Apply button pressed');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                minimumSize: const Size(double.infinity,
                    50), // Set the height and ensure it takes full width
              ),
              child: const Text('Apply',
                  style: TextStyle(fontSize: 18)), // Style the text
            ),
          ),
        );
      },
    );
  }
}
