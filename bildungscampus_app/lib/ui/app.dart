import 'package:bildungscampus_app/core/models/common/local_settings_dto.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/privacy_viewmodel.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bildungscampus_app/core/configs/flavor_config.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final LocalSettingsDto localSettingsDto;

  const MyApp({Key? key, required this.localSettingsDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppViewModel>(
          create: (ctx) => locator<AppViewModel>(),
        ),
        ChangeNotifierProxyProvider<AppViewModel, PrivacyViewModel>(
            create: (ctx) => locator<PrivacyViewModel>(),
            update: (_, appViewModel, privacyViewModel) {
              privacyViewModel!.updateExternalLinks(appViewModel.externalLinks);
              return privacyViewModel;
            }),
      ],
      child: MaterialApp(
        title: 'Mein Bildungscampus',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: AppColors.primaryOneMaterialColor,
          ),
          fontFamily: 'DINOT Medium',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontFamily: 'DINOT Light',
              color: Colors.white,
            ),
            displayMedium: TextStyle(
              fontFamily: 'DINOT Light',
              color: Colors.white,
            ),
            displaySmall: TextStyle(
              fontFamily: 'DINOT Medium',
              color: Colors.white,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'DINOT Medium',
              color: Colors.white,
            ),
            headlineSmall: TextStyle(
              fontFamily: 'DINOT Medium',
              color: AppColors.secondaryTwoColor,
            ),
            titleLarge: TextStyle(
              fontFamily: 'DINOT Medium',
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              fontFamily: 'DINOT Medium',
              color: Colors.white,
            ),
            titleSmall: TextStyle(
              fontFamily: 'DINOT Medium',
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'DINOT Medium',
              color: AppColors.mainTextColor,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'DINOT Medium',
              color: AppColors.mainTextColor,
            ),
            labelLarge: TextStyle(
              fontFamily: 'DINOT Medium',
              color: Colors.white,
            ),
            bodySmall: TextStyle(
              fontFamily: 'DINOT Light',
              color: Colors.white,
            ),
            labelSmall: TextStyle(
              fontFamily: 'DINOT Medium',
              color: Colors.white,
            ),
          ),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: FlavorConfig.instance!.lang,
        initialRoute: localSettingsDto.hideIntro
            ? AppRouter.homeRoute
            : AppRouter.initialRoute,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
