import 'package:bildungscampus_app/core/models/common/local_settings_dto.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/mensa_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/privacy_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/game/models/player_data.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final LocalSettingsDto localSettingsDto;

  const MyApp({
    super.key,
    required this.localSettingsDto,
  });

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
        ChangeNotifierProvider<UserViewModel>(
          create: (ctx) => locator<UserViewModel>(),
        ),
        ChangeNotifierProvider<MensaViewModel>(
          create: (ctx) => locator<MensaViewModel>(),
        ),
        ChangeNotifierProvider<PlayerData>(
          create: (ctx) => PlayerData(),
        ),
      ],
      builder: (context, child) => MaterialApp(
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
        locale: context.select<UserViewModel, Locale?>((x) => x.locale),
        initialRoute: localSettingsDto.hideIntro
            ? AppRouter.homeRoute
            : AppRouter.initialRoute,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
