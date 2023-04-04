import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';

class ReusableAppBars {
  static AppBar transparentAppBar({bool whiteLogo = false}) {
    final logo = whiteLogo ? AppImages.logoWhite : AppImages.logoBlue;
    final backArrowColor = whiteLogo ? Colors.white : AppColors.primaryOneColor;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: SvgPicture.asset(
            logo,
            height: 35,
            alignment: Alignment.centerRight,
          ),
        ),
      ],
      iconTheme: IconThemeData(
        color: backArrowColor,
      ),
    );
  }

  static AppBar transparentAppBarWithTitle(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Transform.translate(
        offset: const Offset(0, 2),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      titleSpacing: 0,
    );
  }

  static AppBar standardAppBar(BuildContext context, String title) {
    return AppBar(
      title: Transform.translate(
        offset: const Offset(0, 2),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      titleSpacing: 0,
    );
  }

  static AppBar extendedAppBar(BuildContext context, String title) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double screenWidth = mediaQueryData.size.width;
    const contentColor = Colors.white;

    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: SvgPicture.asset(
            AppImages.logoWhite,
            height: 35,
            alignment: Alignment.centerRight,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size(0, 40.0),
        child: SizedBox(
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Text(
              title,
              style: const TextStyle(
                color: contentColor,
                fontSize: 21.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: contentColor,
      ),
    );
  }
}
