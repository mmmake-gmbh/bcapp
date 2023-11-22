import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/navigation/reusable_appbars.dart';

class LoginView extends StatelessWidget {
  final String? navigationPath;

  const LoginView({super.key, this.navigationPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBars.standardAppBar(
        context,
        S.of(context).login_view_title,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: RepositoryProvider.value(
          value: locator<CidaasLoginProvider>(),
          child: LoginBrowser(
            reRouteToAfterLogin: navigationPath ?? AppRouter.homeRoute,
            customActionAfterLogin: () async =>
                await context.read<UserViewModel>().initLoggedInData(),
            splashScreen: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
