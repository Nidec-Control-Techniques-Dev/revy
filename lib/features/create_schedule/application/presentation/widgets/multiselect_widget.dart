import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class MultiSelectWidget extends StatelessWidget {
  MultiSelectWidget({super.key});

  final MultiSelectController _controller = MultiSelectController();

  final TextStyle _headerStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('States/Provinces', style: _headerStyle),
            const SizedBox(
              height: 4,
            ),
            MultiSelectDropDown(
              controller: _controller,
              onOptionSelected: (List<ValueItem> selectedOptions) {},
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
             const SizedBox(
              height: 50,
            ),
            Text('Business Models', style: _headerStyle),
            const SizedBox(
              height: 4,
            ),
            MultiSelectDropDown(
              controller: _controller,
              onOptionSelected: (List<ValueItem> selectedOptions) {},
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
            const SizedBox(
              height: 50,
            ),
            Text('Category', style: _headerStyle),
            MultiSelectDropDown(
              controller: _controller,
              onOptionSelected: (List<ValueItem> selectedOptions) {},
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
             const SizedBox(
              height: 50,
            ),
            // Text('Subcategories', style: _headerStyle),
            // MultiSelectDropDown(
            //   controller: _controller,
            //   onOptionSelected: (List<ValueItem> selectedOptions) {},
            //   options: const <ValueItem>[
            //     ValueItem(label: 'Option 1', value: '1'),
            //     ValueItem(label: 'Option 2', value: '2'),
            //     ValueItem(label: 'Option 3', value: '3'),
            //     ValueItem(label: 'Option 4', value: '4'),
            //     ValueItem(label: 'Option 5', value: '5'),
            //     ValueItem(label: 'Option 6', value: '6'),
            //   ],
            //   selectionType: SelectionType.multi,
            //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
            //   dropdownHeight: 300,
            //   optionTextStyle: const TextStyle(fontSize: 16),
            //   selectedOptionIcon: const Icon(Icons.check_circle),
            // ),
            //  const SizedBox(
            //   height: 50,
            // ),
            // Text('Annual Sales', style: _headerStyle),
            // MultiSelectDropDown(
            //   controller: _controller,
            //   onOptionSelected: (List<ValueItem> selectedOptions) {},
            //   options: const <ValueItem>[
            //     ValueItem(label: 'Option 1', value: '1'),
            //     ValueItem(label: 'Option 2', value: '2'),
            //     ValueItem(label: 'Option 3', value: '3'),
            //     ValueItem(label: 'Option 4', value: '4'),
            //     ValueItem(label: 'Option 5', value: '5'),
            //     ValueItem(label: 'Option 6', value: '6'),
            //   ],
            //   selectionType: SelectionType.multi,
            //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
            //   dropdownHeight: 300,
            //   optionTextStyle: const TextStyle(fontSize: 16),
            //   selectedOptionIcon: const Icon(Icons.check_circle),
            // ),
          ],
        ),
      ),
    );
    }
}