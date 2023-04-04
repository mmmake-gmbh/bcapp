import 'package:bildungscampus_app/core/models/common/app_menu.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuListTile extends StatelessWidget {
  final AppMenu appMenu;
  final bool isActive;
  final Color textColor;
  final Color indicatorColor;
  final Function? onTap;

  const MenuListTile({
    Key? key,
    required this.appMenu,
    required this.textColor,
    required this.indicatorColor,
    this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 10,
      title: Text(
        appMenu.title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor: isActive ? indicatorColor : Colors.transparent,
              decorationThickness: 2.0,
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
      leading: Transform.translate(
        offset: const Offset(5, -5),
        child: SvgPicture.asset(
          SvgIcons.arrowRight,
          colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
          height: 20.0,
          width: 19.0,
        ),
      ),
      onTap: () {
        onTap?.call();
      },
    );
  }
}
