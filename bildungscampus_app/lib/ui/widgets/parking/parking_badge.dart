import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ParkingBadge extends StatelessWidget {
  final String text;
  final String iconPath;

  const ParkingBadge({required this.text, required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 20,
      decoration: ShapeDecoration(
        color: AppColors.parkingViewIconsBgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.parkingViewIconsTextColor,
                fontSize: 16,
                fontFamily: 'DINRoundOT Medium',
                fontWeight: FontWeight.w500,
                height: 0.06,
                letterSpacing: 0.09,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 16,
            padding: const EdgeInsets.only(top: 2.0),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: AppColors.parkingViewIconsSeparatorColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: const ColorFilter.mode(
                    AppColors.parkingViewIconsColor, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
