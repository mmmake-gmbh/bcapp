import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticateWidget extends StatefulWidget {
  final String? navigationPath;

  const AuthenticateWidget({super.key, this.navigationPath});

  @override
  State<AuthenticateWidget> createState() => _AuthenticateWidgetState();
}

class _AuthenticateWidgetState extends State<AuthenticateWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: locator<CidaasLoginProvider>(),
      child: LoginBrowser(
        reRouteToAfterLogin: widget.navigationPath ?? AppRouter.homeRoute,
        customActionAfterLogin: () async {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final userViewModel = context.read<UserViewModel>();
          final localization = S.of(context);

          await userViewModel.initLoggedInData();

          if (userViewModel.isBiometricInitialized ||
              userViewModel.useBiometricLoginActivated) {
            return;
          }

          scaffoldMessenger.showMaterialBanner(MaterialBanner(
              content: Text(localization.login_view_prompt_biometric_text),
              actions: [
                TextButton(
                  onPressed: () async {
                    await userViewModel.updateBiometricLogin(true);
                    scaffoldMessenger.hideCurrentMaterialBanner();
                  },
                  child: Text(
                      localization.login_view_prompt_biometric_accept_button),
                ),
                TextButton(
                  onPressed: () {
                    scaffoldMessenger.hideCurrentMaterialBanner();
                  },
                  child: Text(
                      localization.login_view_prompt_biometric_dismiss_button),
                ),
              ]));
        },
        splashScreen: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryOneColor,
          ),
        ),
      ),
    );
  }
}
