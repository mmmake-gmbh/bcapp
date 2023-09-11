import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/navigation/reusable_appbars.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBars.standardAppBar(
        context,
        'Login',
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: RepositoryProvider.value(
          value: locator<CidaasLoginProvider>(),
          child: LoginBrowser(
            reRouteToAfterLogin: AppRouter.homeRoute,
            customActionAfterLogin: () async =>
                await context.read<UserViewModel>().loggedIn(),
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
