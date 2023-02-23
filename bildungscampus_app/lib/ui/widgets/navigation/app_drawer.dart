import 'package:bildungscampus_app/core/enums/app_menu_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/app_menu.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/privacy_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/menu_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppDrawer extends StatelessWidget {
  bool _isAppMenuItemCurrentRoute(
      ModalRoute<Object?> modalRoute, AppMenu menuItem) {
    final currentRouteName = modalRoute.settings.name ?? '';
    return menuItem.navigationPath == currentRouteName;
  }

  @override
  Widget build(BuildContext context) {
    final currentModalRoute = ModalRoute.of(context);

    final mainMenu = context.select((AppViewModel model) => model.mainMenu);
    final privacyAgreementLink =
        context.select((PrivacyViewModel model) => model.privacyAgreementLink);
    final termsOfUseLink =
        context.select((PrivacyViewModel model) => model.termsOfUseLink);

    final homeMenu = AppMenu(
      title: S.of(context).home_view_appmenu_title,
      type: AppMenuType.Home,
      navigationPath: AppRouter.homeRoute,
    );

    final additionalMenu = [
      AppMenu(
        title: S.of(context).contact_view_appmenu_title,
        type: AppMenuType.Contact,
        navigationPath: AppRouter.contactRoute,
      ),
      AppMenu(
        title: S.of(context).privacy_view_appmenu_title,
        type: AppMenuType.Privacy,
        externalPath: privacyAgreementLink,
      ),
      AppMenu(
        title: S.of(context).termsofuse_view_appmenu_title,
        type: AppMenuType.Privacy,
        externalPath: termsOfUseLink,
      ),
    ];

    return Drawer(
      child: Container(
        color: AppColors.primaryOneColor,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15.0, bottom: 28.0),
                child: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRouter.homeRoute),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      AppImages.logoWhite,
                      height: 46.0,
                    ),
                  ),
                ),
              ),
              MenuListTile(
                appMenu: homeMenu,
                textColor: AppColors.primaryOneTextColor,
                indicatorColor: AppColors.primaryTwoColor,
                onTap: () => Navigator.pushNamed(context, AppRouter.homeRoute),
                isActive:
                    _isAppMenuItemCurrentRoute(currentModalRoute!, homeMenu),
              ),
              if (mainMenu != null)
                ...mainMenu
                    .map(
                      (appMenu) => MenuListTile(
                        appMenu: appMenu,
                        textColor: AppColors.primaryOneTextColor,
                        indicatorColor: AppColors.primaryTwoColor,
                        onTap: () => Navigator.pushNamed(
                            context, appMenu.navigationPath!),
                        isActive: _isAppMenuItemCurrentRoute(
                            currentModalRoute, appMenu),
                      ),
                    )
                    .toList(),
              SizedBox(height: 40),
              ...additionalMenu
                  .map((appMenu) => MenuListTile(
                        appMenu: appMenu,
                        textColor: AppColors.primaryTwoLightColor,
                        indicatorColor: Colors.white,
                        isActive: _isAppMenuItemCurrentRoute(
                            currentModalRoute, appMenu),
                        onTap: () {
                          if (appMenu.navigationPath == null &&
                              appMenu.externalPath != null) {
                            launchUrlString(appMenu.externalPath!);
                          } else if (appMenu.navigationPath != null) {
                            Navigator.pushNamed(
                                context, appMenu.navigationPath!);
                          }
                        },
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
