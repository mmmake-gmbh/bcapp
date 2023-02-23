import 'package:bildungscampus_app/core/services/interfaces/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:bildungscampus_app/core/configs/flavor_config.dart';
import 'package:bildungscampus_app/ui/app.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    flavor: Flavor.DEV,
    color: Colors.deepPurpleAccent,
    values: FlavorValues(
        apiGatewayUrl: "http://localhost:8080",
        identityServerUrl: "http://localhost",
        identityClientId: "empty",
        identityClientSecret: "empty",
        identityScheme: 'com.schwarzit.bildungscampus.app'),
  );
  setupLocator();
  final settingsService = locator<SettingsService>();
  final localSettings = await settingsService.loadSettings();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(localSettingsDto: localSettings));
  });
}
