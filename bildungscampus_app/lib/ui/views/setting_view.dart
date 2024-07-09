import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/core/models/settings/setting_view_args.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  Future<void> onTileTap(
      {required BuildContext context,
      required ExternalLink? settingValue,
      required String title}) async {
    final navigator = Navigator.of(context);
    final snackbar = ScaffoldMessenger.of(context);
    final logoutText = Text(S.of(context).setting_view_logout_unsuccessful);
    if (settingValue == null) {
      return;
    }

    if (settingValue.name == 'logout') {
      final logoutSuccessful =
          await context.read<UserViewModel>().logout(context);

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
      final args = SettingViewArgs(externalLink: settingValue, title: title);
      navigator.pushNamed(AppRouter.settingWebRoute, arguments: args);
    }
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
                      onChanged: (newValue) {
                        final viewModel = context.read<UserViewModel>();

                        if (viewModel.useBiometricLoginActivated != newValue) {
                          viewModel.updateBiometricLogin(newValue);
                        }
                      }),
                );
              }
              if (isLogged && index == 5) {
                return const SizedBox.shrink();
              }
              return ListTile(
                title: Text(settings[index].key),
                titleTextStyle: const TextStyle(
                    color: AppColors.settingListTileTitleColor, fontSize: 16.0),
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
