import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';

class ReusableAppBars {
  static TextStyle standardTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

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
          style: standardTextStyle,
          textAlign: TextAlign.left,
        ),
      ),
      titleSpacing: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  static AppBar standardAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: AppColors.primaryOneColor,
      title: Transform.translate(
        offset: const Offset(0, 2),
        child: Text(
          title,
          style: standardTextStyle,
          textAlign: TextAlign.left,
        ),
      ),
      titleSpacing: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  static AppBar lightAppBarWithLogo(BuildContext context,
      {required List<Widget> actions}) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarOpacity: 0.9,
      title: SvgPicture.asset(
        SvgIcons.logo,
        height: 32,
        alignment: Alignment.center,
      ),
      actions: actions,
      iconTheme: const IconThemeData(
        color: AppColors.homeAppBarColor,
      ),
    );
  }

  static AppBar lightAppBarWithText(BuildContext context,
      {required String title}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      toolbarOpacity: 0.9,
      title: Transform.translate(
        offset: const Offset(0, 2),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 16.0, color: AppColors.homeAppBarColor),
          textAlign: TextAlign.left,
        ),
      ),
      titleSpacing: 0,
      iconTheme: const IconThemeData(
        color: AppColors.homeAppBarColor,
      ),
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
