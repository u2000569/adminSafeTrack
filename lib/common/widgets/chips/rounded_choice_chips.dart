import 'package:adminpickready/common/widgets/containers/circular_container.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SChoiceChip extends StatelessWidget {
  /// Create a chip that acts like a radio button.
  ///
  /// Parameters:
  ///   - text: The label text for the chip.
  ///   - selected: Whether the chip is currently selected.
  ///   - onSelected: Callback function when the chip is selected.
  const SChoiceChip({
    super.key, 
    required this.text, 
    required this.selected, 
    this.onSelected
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Use a transparent canvas color to match the existing styling.
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        // Use this function to get Colors as a Chip
        avatar: SHelperFunctions.getColor(text) != null
            ? SCircularContainer(width: 50, height: 50, backgroundColor: SHelperFunctions.getColor(text)!)
            : null,
        selected: selected,
        onSelected: onSelected,
        backgroundColor: SHelperFunctions.getColor(text),
        labelStyle: TextStyle(color: selected ? SColors.white : null),
        shape: SHelperFunctions.getColor(text) != null ? const CircleBorder() : null,
        label: SHelperFunctions.getColor(text) == null ? Text(text) : const SizedBox(),
        padding: SHelperFunctions.getColor(text) != null ? const EdgeInsets.all(0) : null,
        labelPadding: SHelperFunctions.getColor(text) != null ? const EdgeInsets.all(0) : null,
      ),
    );
  }
}