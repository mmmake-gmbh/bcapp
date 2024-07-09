import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class IntroCard extends StatelessWidget {
  final IconData icon;
  final String titleText;
  final String text;

  const IntroCard(
      {super.key,
      required this.icon,
      required this.titleText,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.mensaBgColor,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mensaBgColor,
                    fontFamily: "DIN OT",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: "DIN OT",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
