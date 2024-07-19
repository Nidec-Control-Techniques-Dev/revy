import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../.././../bloc/create_schedule_bloc.dart';
import '../.././../bloc/client_config_bloc.dart';

class MultiSelectWidget extends StatefulWidget {
  const MultiSelectWidget({super.key});

  @override
  _MultiSelectWidgetState createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  final MultiSelectController _statesController = MultiSelectController();
  final MultiSelectController _businessModelsController = MultiSelectController();
  final MultiSelectController _categoriesController = MultiSelectController();

  final TextStyle _headerStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        if (state is DataLoaded) {
          // Convert List<String> to List<ValueItem>
          List<ValueItem> stateOptions = state.statesOptions;
          List<ValueItem> businessModelOptions = state.businessModelsOptions;
          List<ValueItem> categoryOptions = state.categoriesOptions;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('States/Provinces', style: _headerStyle),
                  const SizedBox(height: 4),
                  MultiSelectDropDown(
                    controller: _statesController,
                    onOptionSelected: (List<ValueItem> selectedStates) {
                      setState(() {
                        // _selectedStates = selectedStates;
                        context.read<CreateScheduleBloc>().add(
                          ClientConfigStageStarted(
                            chosenStates: selectedStates.map((e) => e.value).toList().cast<String>(),
                          ),
                        );
                      });
                    },
                    options: stateOptions,
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    dropdownHeight: 300,
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  ),
                  const SizedBox(height: 50),
                  Text('Business Models', style: _headerStyle),
                  const SizedBox(height: 4),
                  MultiSelectDropDown(
                    controller: _businessModelsController,
                    onOptionSelected: (List<ValueItem> selectedBusinessModels) {
                      setState(() {
                        // _selectedBusinessModels = selectedBusinessModels;
                        context.read<CreateScheduleBloc>().add(
                          ClientConfigStageStarted(
                            chosenBusinessModels: selectedBusinessModels.map((e) => e.value).toList().cast<String>(),
                          ),
                        );
                      });
                    },
                    options: businessModelOptions,
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    dropdownHeight: 300,
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  ),
                  const SizedBox(height: 50),
                  Text('Category', style: _headerStyle),
                  const SizedBox(height: 4),
                  MultiSelectDropDown(
                    controller: _categoriesController,
                    onOptionSelected: (List<ValueItem> selectedCategories) {
                      setState(() {
                        // _selectedCategories = selectedCategories;
                        context.read<CreateScheduleBloc>().add(
                          ClientConfigStageStarted(
                            chosenCategories: selectedCategories.map((e) => e.value).toList().cast<String>(),
                          ),
                        );
                      });
                    },
                    options: categoryOptions,
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    dropdownHeight: 300,
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
