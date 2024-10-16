import 'dart:developer';

import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final auth = LocalAuthentication();
  bool _showBiometrics = false;

  Future<void> onTileTap(
      {required BuildContext context,
      required ExternalLink? settingValue,
      required String title}) async {
    final navigator = Navigator.of(context);
    final snackbar = ScaffoldMessenger.of(context);
    final logoutText = Text(S.of(context).setting_view_logout_unsuccessful);
    final locale = context.read<UserViewModel>().locale;
    if (settingValue == null) {
      return;
    }

    if (settingValue.name == 'logout') {
      final logoutSuccessful = await context.read<UserViewModel>().logout();

      if (logoutSuccessful) {
        navigator.pushNamed(AppRouter.homeRoute);
      } else {
        snackbar.showSnackBar(SnackBar(content: logoutText));
      }
    } else if (settingValue.name == 'login') {
      navigator.pushNamed(
        AppRouter.loginRoute,
        arguments: AppRouter.homeRoute,
      );
    } else {
      final url =
          LocalizedTextUtils.getLocalizedText(settingValue.link, locale);

      log("settingView url: $url");
      await launchUrlString(url);
    }
  }

  Future<void> checkBiometrics() async {
    final biometricSupported = await auth.isDeviceSupported();

    final canCheckBiometric = await auth.canCheckBiometrics;

    setState(
      () => _showBiometrics = biometricSupported && canCheckBiometric,
    );
  }

  @override
  void initState() {
    super.initState();

    checkBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    final appViewModel = context.read<AppViewModel>();

    final isLogged =
        context.select<UserViewModel, bool>((viewModel) => viewModel.isLogged);

    final loggedInSettings = <String, ExternalLink?>{
      S.of(context).setting_view_account_setting:
          appViewModel.accountSettingLink,
      S.of(context).setting_view_sessions_setting:
          appViewModel.sessionsSettingLink,
      S.of(context).setting_view_campus_card_setting:
          appViewModel.campusCardSettingLink,
      S.of(context).setting_view_logout_setting: ExternalLink(
        name: "logout",
        link: [LocalizedText(lang: "de", text: "logout")],
        openExternalInBrowser: false,
      )
    }.entries.toList();

    final defaultSettings = <String, ExternalLink?>{
      "Login": ExternalLink(
        name: "login",
        link: [LocalizedText(lang: "de", text: "login")],
        openExternalInBrowser: false,
      )
    }.entries.toList();

    final settings = isLogged ? loggedInSettings : defaultSettings;

    return Scaffold(
      appBar: ReusableAppBars.lightAppBarWithText(context,
          title: S.of(context).setting_view_title),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.settingBgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: ((context, index) {
              if ((isLogged && index == 4) || (!isLogged && index == 1)) {
                return Selector<UserViewModel, bool>(
                  selector: (_, viewModel) =>
                      viewModel.useBiometricLoginActivated,
                  builder: (context, activated, _) => SwitchListTile(
                      title: Text(
                        S.of(context).setting_view_biometric_setting_text,
                      ),
                      value: activated,
                      onChanged: !_showBiometrics
                          ? null
                          : (newValue) async {
                              final viewModel = context.read<UserViewModel>();
                              final localized = S.of(context);

                              if (!newValue && _showBiometrics) {
                                final authenticated = await auth.authenticate(
                                  localizedReason: localized
                                      .login_view_biometric_authenticate_reason,
                                  options: const AuthenticationOptions(
                                    stickyAuth: true,
                                    biometricOnly: true,
                                  ),
                                );

                                if (!authenticated) {
                                  return;
                                }
                              }

                              if (viewModel.useBiometricLoginActivated !=
                                  newValue) {
                                viewModel.updateBiometricLogin(newValue);
                              }
                            }),
                );
              }
              /*if ((isLogged && index == 5) || (!isLogged && index == 2)) {
                return ListTile(
                  title: const Text(
                    'Datenschutzeinstellungen', //TODO: Translation
                  ),
                  onTap: () {
                    //context.read<UserViewModel>().showPreferenceCenter();
                  },
                  trailing: const Icon(Icons.settings),
                );
              }*/
              if (isLogged && index == 5) {
                return const SizedBox.shrink();
              }
              return ListTile(
                title: Text(settings[index].key),
                trailing: SvgPicture.asset(
                  SvgIcons.ungroup,
                  height: 18,
                  alignment: Alignment.centerRight,
                ),
                onTap: () async => await onTileTap(
                  context: context,
                  settingValue: settings[index].value,
                  title: settings[index].key,
                ),
              );
            }),
            separatorBuilder: (context, index) =>
                const Divider(color: AppColors.settingListTileSeparatorColor),
            itemCount: isLogged ? 6 : 2,
          ),
        ),
      ),
    );
  }
}
