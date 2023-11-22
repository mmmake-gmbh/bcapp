import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/app_menu.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/privacy_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/menu_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  bool _isAppMenuItemCurrentRoute(
      ModalRoute<Object?> modalRoute, AppMenu menuItem) {
    final currentRouteName = modalRoute.settings.name ?? '';
    return menuItem.navigationPath == currentRouteName;
  }

  Future<void> saveSelectedLocale(BuildContext context, String lang) async {
    final allLocales =
        context.findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales;
    final userViewModel = context.read<UserViewModel>();

    final selectedLocale =
        allLocales?.firstWhere((element) => element.languageCode == lang);

    if (selectedLocale != null) {
      await userViewModel.saveLanguage(selectedLocale);
    }
  }

  void appMenuOnTap(BuildContext context, AppMenu appMenu) {
    if (appMenu.navigationPath == null && appMenu.externalPath != null) {
      launchUrlString(appMenu.externalPath!);
    } else if (appMenu.navigationPath != null) {
      final isLogged = context.read<UserViewModel>().isLogged;

      if ((appMenu.type == FeatureType.payment ||
              appMenu.type == FeatureType.kienzlerBike) &&
          !isLogged) {
        Navigator.pushNamed(context, AppRouter.loginRoute,
            arguments: appMenu.navigationPath!);
        return;
      }

      Navigator.pushNamed(context, appMenu.navigationPath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentModalRoute = ModalRoute.of(context);

    final mainMenu = context.select((AppViewModel model) => model.mainMenu);

    final privacyAgreementLink =
        context.select((PrivacyViewModel model) => model.privacyAgreementLink);
    final termsOfUseLink =
        context.select((PrivacyViewModel model) => model.termsOfUseLink);

    final locale = context.select((UserViewModel model) => model.locale);

    final homeMenu = AppMenu(
      title: [],
      simpleTitle: S.of(context).home_view_appmenu_title,
      type: FeatureType.home,
      navigationPath: AppRouter.homeRoute,
      allowedUserType: UserType.notLoggedIn,
    );

    final additionalMenu = [
      AppMenu(
        title: [],
        simpleTitle: S.of(context).contact_view_appmenu_title,
        type: FeatureType.contact,
        navigationPath: AppRouter.contactRoute,
        allowedUserType: UserType.notLoggedIn,
      ),
      AppMenu(
        title: [],
        simpleTitle: S.of(context).privacy_view_appmenu_title,
        type: FeatureType.privacy,
        externalPath: privacyAgreementLink,
        allowedUserType: UserType.notLoggedIn,
      ),
      AppMenu(
        title: [],
        simpleTitle: S.of(context).termsofuse_view_appmenu_title,
        type: FeatureType.privacy,
        externalPath: termsOfUseLink,
        allowedUserType: UserType.notLoggedIn,
      ),
    ];

    return Drawer(
      child: Container(
        color: AppColors.primaryOneColor,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
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
                      height: 35.0,
                    ),
                  ),
                ),
              ),
              MenuListTile(
                appMenu: homeMenu,
                locale: locale,
                textColor: AppColors.primaryOneTextColor,
                indicatorColor: AppColors.drawerMenuTileUnderlineColor,
                onTap: () => Navigator.pushNamed(context, AppRouter.homeRoute),
                isActive:
                    _isAppMenuItemCurrentRoute(currentModalRoute!, homeMenu),
              ),
              if (mainMenu != null)
                ...mainMenu.map(
                  (appMenu) => MenuListTile(
                    appMenu: appMenu,
                    locale: locale,
                    textColor: AppColors.primaryOneTextColor,
                    indicatorColor: AppColors.drawerMenuTileUnderlineColor,
                    onTap: () => appMenuOnTap(context, appMenu),
                    isActive:
                        _isAppMenuItemCurrentRoute(currentModalRoute, appMenu),
                  ),
                ),
              const SizedBox(height: 20),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              const SizedBox(height: 20),
              ...additionalMenu.map((appMenu) => MenuListTile(
                    appMenu: appMenu,
                    locale: locale,
                    textColor: AppColors.drawerMenuTileUnderlineColor,
                    indicatorColor: Colors.white,
                    isActive:
                        _isAppMenuItemCurrentRoute(currentModalRoute, appMenu),
                    onTap: () => appMenuOnTap(context, appMenu),
                  )),
              Consumer<UserViewModel>(
                builder: (context, userViewModel, child) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await saveSelectedLocale(context, 'de');
                        },
                        child: Text(
                          'DE',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontFamily: Localizations.localeOf(context)
                                              .languageCode ==
                                          'de'
                                      ? 'DINOT Bold'
                                      : 'DINOT Light',
                                  color:
                                      AppColors.drawerMenuTileUnderlineColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '|',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontFamily: 'DINOT Bold',
                                  color:
                                      AppColors.drawerMenuTileUnderlineColor),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await saveSelectedLocale(context, 'en');
                        },
                        child: Text(
                          'EN',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontFamily: Localizations.localeOf(context)
                                              .languageCode ==
                                          'en'
                                      ? 'DINOT Bold'
                                      : 'DINOT Light',
                                  color:
                                      AppColors.drawerMenuTileUnderlineColor),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
