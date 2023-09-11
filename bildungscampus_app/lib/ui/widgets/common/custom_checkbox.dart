import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;

  const CustomCheckbox({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  Color getCheckboxColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.primaryTwoColor;
    }
    return AppColors.checkBoxBgColor;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Container(
            height: 24,
            width: 24,
            color: AppColors.checkBoxBgColor,
          ),
        ),
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
              value: value,
              onChanged: onChanged,
              fillColor: MaterialStateProperty.resolveWith(getCheckboxColor),
              checkColor: AppColors.primaryOneColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)))),
        )
      ],
    );
  }
}
