import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../.././../bloc/create_schedule_bloc.dart';

class MultiSelectWidget extends StatefulWidget {
  const MultiSelectWidget({super.key});

  @override
  _MultiSelectWidgetState createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  final MultiSelectController _controller = MultiSelectController();

  final TextStyle _headerStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  List<ValueItem> _selectedStates = [];
  List<ValueItem> _selectedBusinessModels = [];
  List<ValueItem> _selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('States/Provinces', style: _headerStyle),
            const SizedBox(height: 4),
            MultiSelectDropDown(
              controller: _controller,
              onOptionSelected: (List<ValueItem> selectedStates) {
                setState(() {
                  _selectedStates = selectedStates;
                  context.read<CreateScheduleBloc>().add(ClientConfigStageStarted(chosenStates : selectedStates.map((e) => e.label).toList()));
                });
              },
              options: const <ValueItem>[
                ValueItem(label: 'Option 1', value: '1'),
                ValueItem(label: 'Option 2', value: '2'),
                ValueItem(label: 'Option 3', value: '3'),
                ValueItem(label: 'Option 4', value: '4'),
                ValueItem(label: 'Option 5', value: '5'),
                ValueItem(label: 'Option 6', value: '6'),
              ],
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
              controller: _controller,
              onOptionSelected: (List<ValueItem> selectedBusinessModels) {
                setState(() {
                  _selectedBusinessModels = selectedBusinessModels;
                  context.read<CreateScheduleBloc>().add(ClientConfigStageStarted(chosenBusinessModels : selectedBusinessModels.map((e) => e.label).toList()));
                });
              },
              options: const <ValueItem>[
                ValueItem(label: 'Option 1', value: '1'),
                ValueItem(label: 'Option 2', value: '2'),
                ValueItem(label: 'Option 3', value: '3'),
                ValueItem(label: 'Option 4', value: '4'),
                ValueItem(label: 'Option 5', value: '5'),
                ValueItem(label: 'Option 6', value: '6'),
              ],
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
              controller: _controller,
              onOptionSelected: (List<ValueItem> selectedCategories) {
                setState(() {
                  _selectedCategories = selectedCategories;
                  context.read<CreateScheduleBloc>().add(ClientConfigStageStarted(chosenCategories : selectedCategories.map((e) => e.label).toList()));
                });
              },
              options: const <ValueItem>[
                ValueItem(label: 'Option 1', value: '1'),
                ValueItem(label: 'Option 2', value: '2'),
                ValueItem(label: 'Option 3', value: '3'),
                ValueItem(label: 'Option 4', value: '4'),
                ValueItem(label: 'Option 5', value: '5'),
                ValueItem(label: 'Option 6', value: '6'),
              ],
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
  }
}


// import 'package:flutter/material.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';

// class MultiSelectWidget extends StatelessWidget {
//   MultiSelectWidget({super.key});

//   final MultiSelectController _controller = MultiSelectController();

//   final TextStyle _headerStyle = const TextStyle(
//     fontSize: 24,
//     fontWeight: FontWeight.bold,
//     color: Colors.black,
//   );

//    @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('States/Provinces', style: _headerStyle),
//             const SizedBox(
//               height: 4,
//             ),
//             MultiSelectDropDown(
//               controller: _controller,
//               onOptionSelected: (List<ValueItem> selectedOptions) {},
//               options: const <ValueItem>[
//                 ValueItem(label: 'Option 1', value: '1'),
//                 ValueItem(label: 'Option 2', value: '2'),
//                 ValueItem(label: 'Option 3', value: '3'),
//                 ValueItem(label: 'Option 4', value: '4'),
//                 ValueItem(label: 'Option 5', value: '5'),
//                 ValueItem(label: 'Option 6', value: '6'),
//               ],
//               selectionType: SelectionType.multi,
//               chipConfig: const ChipConfig(wrapType: WrapType.wrap),
//               dropdownHeight: 300,
//               optionTextStyle: const TextStyle(fontSize: 16),
//               selectedOptionIcon: const Icon(Icons.check_circle),
//             ),
//              const SizedBox(
//               height: 50,
//             ),
//             Text('Business Models', style: _headerStyle),
//             const SizedBox(
//               height: 4,
//             ),
//             MultiSelectDropDown(
//               controller: _controller,
//               onOptionSelected: (List<ValueItem> selectedOptions) {},
//               options: const <ValueItem>[
//                 ValueItem(label: 'Option 1', value: '1'),
//                 ValueItem(label: 'Option 2', value: '2'),
//                 ValueItem(label: 'Option 3', value: '3'),
//                 ValueItem(label: 'Option 4', value: '4'),
//                 ValueItem(label: 'Option 5', value: '5'),
//                 ValueItem(label: 'Option 6', value: '6'),
//               ],
//               selectionType: SelectionType.multi,
//               chipConfig: const ChipConfig(wrapType: WrapType.wrap),
//               dropdownHeight: 300,
//               optionTextStyle: const TextStyle(fontSize: 16),
//               selectedOptionIcon: const Icon(Icons.check_circle),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             Text('Category', style: _headerStyle),
//             MultiSelectDropDown(
//               controller: _controller,
//               onOptionSelected: (List<ValueItem> selectedOptions) {},
//               options: const <ValueItem>[
//                 ValueItem(label: 'Option 1', value: '1'),
//                 ValueItem(label: 'Option 2', value: '2'),
//                 ValueItem(label: 'Option 3', value: '3'),
//                 ValueItem(label: 'Option 4', value: '4'),
//                 ValueItem(label: 'Option 5', value: '5'),
//                 ValueItem(label: 'Option 6', value: '6'),
//               ],
//               selectionType: SelectionType.multi,
//               chipConfig: const ChipConfig(wrapType: WrapType.wrap),
//               dropdownHeight: 300,
//               optionTextStyle: const TextStyle(fontSize: 16),
//               selectedOptionIcon: const Icon(Icons.check_circle),
//             ),
//              const SizedBox(
//               height: 50,
//             ),
//             // Text('Subcategories', style: _headerStyle),
//             // MultiSelectDropDown(
//             //   controller: _controller,
//             //   onOptionSelected: (List<ValueItem> selectedOptions) {},
//             //   options: const <ValueItem>[
//             //     ValueItem(label: 'Option 1', value: '1'),
//             //     ValueItem(label: 'Option 2', value: '2'),
//             //     ValueItem(label: 'Option 3', value: '3'),
//             //     ValueItem(label: 'Option 4', value: '4'),
//             //     ValueItem(label: 'Option 5', value: '5'),
//             //     ValueItem(label: 'Option 6', value: '6'),
//             //   ],
//             //   selectionType: SelectionType.multi,
//             //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
//             //   dropdownHeight: 300,
//             //   optionTextStyle: const TextStyle(fontSize: 16),
//             //   selectedOptionIcon: const Icon(Icons.check_circle),
//             // ),
//             //  const SizedBox(
//             //   height: 50,
//             // ),
//             // Text('Annual Sales', style: _headerStyle),
//             // MultiSelectDropDown(
//             //   controller: _controller,
//             //   onOptionSelected: (List<ValueItem> selectedOptions) {},
//             //   options: const <ValueItem>[
//             //     ValueItem(label: 'Option 1', value: '1'),
//             //     ValueItem(label: 'Option 2', value: '2'),
//             //     ValueItem(label: 'Option 3', value: '3'),
//             //     ValueItem(label: 'Option 4', value: '4'),
//             //     ValueItem(label: 'Option 5', value: '5'),
//             //     ValueItem(label: 'Option 6', value: '6'),
//             //   ],
//             //   selectionType: SelectionType.multi,
//             //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
//             //   dropdownHeight: 300,
//             //   optionTextStyle: const TextStyle(fontSize: 16),
//             //   selectedOptionIcon: const Icon(Icons.check_circle),
//             // ),
//           ],
//         ),
//       ),
//     );
//     }
// }