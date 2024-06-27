import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';
import '../../../bloc/get_params_bloc.dart';

// Assuming GetParamsBloc and ApplyButtonPressed are defined elsewhere
class ButtonApply extends StatelessWidget {
  // final String filterStatus;
  // final DateTime startDate;
  // final DateTime endDate;

  const ButtonApply({
    Key? key,
    // required this.startDate,
    // required this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetParamsBloc, GetParamsState>(
      builder: (context, state) {
        return Center(
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
            child: const Text('Apply'),
          ),
        );
      },
    );
  }
}
