import 'package:bildungscampus_app/core/models/common/app_menu.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuListTile extends StatelessWidget {
  final AppMenu appMenu;
  final Locale? locale;
  final bool isActive;
  final Color textColor;
  final Color indicatorColor;
  final Function? onTap;

  const MenuListTile({
    Key? key,
    required this.appMenu,
    required this.locale,
    required this.textColor,
    required this.indicatorColor,
    this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = appMenu.simpleTitle != null && appMenu.simpleTitle!.isNotEmpty
        ? appMenu.simpleTitle
        : LocalizedTextUtils.getLocalizedText(appMenu.title, locale);

    return ListTile(
      minLeadingWidth: 28,
      title: Text(
        text!,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor: isActive ? indicatorColor : Colors.transparent,
              fontFamily: isActive ? 'DINOT Bold' : 'DINOT Light',
              decorationThickness: 1.5,
              shadows: [
                Shadow(
                  color: textColor,
                  offset: const Offset(0, -5),
                )
              ],
              height: 1.1875,
              letterSpacing: 0.09,
            ),
      ),
      leading: SvgPicture.asset(
        SvgIcons.arrowRight,
        colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
        height: 16.0,
        width: 16.0,
      ),
      onTap: () {
        onTap?.call();
      },
    );
  }
}
