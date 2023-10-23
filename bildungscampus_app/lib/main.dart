//import 'dart:convert';

import 'package:bildungscampus_app/core/services/interfaces/settings_service.dart';
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

  FlavorConfig(
    flavor: Flavor.dev,
    color: Colors.deepPurpleAccent,
    values: FlavorValues(
      apiGatewayUrl: "http://10.0.2.2:8080",
      identityServerUrl: "http://localhost",
      identityClientId: "empty",
      identityClientSecret: "empty",
      identityScheme: 'com.schwarzit.bildungscampus.app',
      useIdentity: false,
    ),
  );

  FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));
  final config = CidaasConfig(
      baseUrl: 'http://127.0.0.1',
      clientId: 'empty',
      clientSecret: 'empty',
      redirectURI: 'http://127.0.0.1',
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
