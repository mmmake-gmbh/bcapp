import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/ui/widgets/auth/authenticate_widget.dart';
import 'package:flutter/material.dart';

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: AuthenticateWidget(
          navigationPath: navigationPath,
        ),
      ),
    );
  }
}
