import 'dart:io';

import 'package:bildungscampus_app/core/services/interfaces/settings_service.dart';
import 'package:bildungscampus_app/develop.dart';
import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:bildungscampus_app/core/configs/flavor_config.dart';
import 'package:bildungscampus_app/ui/app.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This opens the app in fullscreen mode.
  await Flame.device.fullScreen();

  HttpOverrides.global = DevelopHttpOverrides();

  FlavorConfig(
    flavor: Flavor.production,
    color: Colors.deepPurpleAccent,
    values: FlavorValues(
      apiGatewayUrl: "https://bcapp-dev.bildungscampus.hn",
      identityServerUrl: "https://bcapp-api-dev.bildungscampus.hn",
      identityClientId: "bildungsCampusApp",
      identityScheme: 'com.schwarzit.bildungscampus.app',
      useIdentity: true,
      identityClientSecret: "secret",
    ),
  );

  FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));
  final config = CidaasConfig(
      baseUrl: 'https://schwarzbc-dev.cidaas.de',
      clientId: 'cf0b53f3-aa4f-4728-a18a-d3cc7a205f23',
      clientSecret: '1d24895c-e99c-4e6f-a202-0f99d303ccd5',
      redirectURI: 'https://schwarzbc-dev.cidaas.de',
      scopes: 'openid profile email offline_access');
  final openIdConfig = await CidaasLoginProvider.loadConfig(config);

  setupLocator(
      secureStorage: storage, openIdConfig: openIdConfig, cidaasConfig: config);
  final settingsService = locator<SettingsService>();
  final localSettings = await settingsService.loadSettings();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MyApp(
        localSettingsDto: localSettings,
      ),
    );
  });
}
