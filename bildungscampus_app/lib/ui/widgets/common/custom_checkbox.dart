import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;

  const CustomCheckbox(
      {super.key, required this.value, required this.onChanged});

  Color getCheckboxColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
      WidgetState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.primaryTwoColor;
    }
    return AppColors.checkBoxBgColor;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        fillColor: WidgetStateProperty.resolveWith(getCheckboxColor),
        checkColor: AppColors.primaryOneColor,
        side: BorderSide.none,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3.0),
          ),
        ),
      ),
    );
  }
}
