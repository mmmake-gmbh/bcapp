import 'package:bildungscampus_app/core/repositories/mensa/api_mensa_repository.dart';
import 'package:bildungscampus_app/core/repositories/mensa/mensa_repository.dart';
import 'package:bildungscampus_app/core/repositories/startscreen/api_app_content_repository.dart';
import 'package:bildungscampus_app/core/repositories/startscreen/app_content_repository.dart';
import 'package:bildungscampus_app/core/services/drawer/campus_menu_service.dart';
import 'package:bildungscampus_app/core/services/drawer/menu_service.dart';
import 'package:bildungscampus_app/core/services/weather/api_weather_service.dart';
import 'package:bildungscampus_app/core/services/weather/weather_service.dart';
import 'package:bildungscampus_app/core/viewmodels/mensa_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/privacy_viewmodel.dart';

import 'package:bildungscampus_app/core/repositories/weather/api_weather_repository.dart';
import 'package:bildungscampus_app/core/repositories/weather/weather_repository.dart';
import 'package:bildungscampus_app/core/repositories/intro/intro_repository.dart';
import 'package:bildungscampus_app/core/repositories/intro/local_intro_repository.dart';

import 'package:bildungscampus_app/core/services/oauth_auth_service.dart';
import 'package:bildungscampus_app/core/services/interfaces/auth_service.dart';
import 'package:bildungscampus_app/core/services/interfaces/settings_service.dart';
import 'package:bildungscampus_app/core/services/local_settings_service.dart';
import 'package:bildungscampus_app/core/services/startscreen/campus_tiles_service.dart';
import 'package:bildungscampus_app/core/services/startscreen/tiles_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(
    {required FlutterSecureStorage secureStorage,
    required CidaasConfig cidaasConfig,
    required OpenIdConfiguration openIdConfig}) {
  locator.registerLazySingleton<TilesService>(() => CampusTilesService());
  locator.registerLazySingleton<MenuService>(() => CampusMenuService());
  locator.registerLazySingleton<AuthService>(() => OAuthAuthService());
  locator.registerLazySingleton<SettingsService>(() => LocalSettingsService());
  locator
      .registerLazySingleton<WeatherRepository>(() => ApiWeatherRepository());
  locator.registerLazySingleton<MensaRepository>(() => ApiMensaRepository());
  locator.registerLazySingleton<IntroRepository>(() => LocalIntroRepository());
  locator.registerLazySingleton<AppContentRepository>(
      () => ApiAppContentRepository());
  locator.registerLazySingleton<WeatherService>(() => ApiWeatherService());
  locator.registerLazySingleton<PrivacyViewModel>(() => PrivacyViewModel());
  locator.registerSingleton(() => secureStorage);
  locator.registerSingleton(CidaasLoginProvider(
      securityStorage: secureStorage,
      cidaasConf: cidaasConfig,
      openIdConfiguration: openIdConfig));
  locator.registerLazySingleton(() => AppViewModel(secureStorage));
  locator.registerLazySingleton(() => UserViewModel(secureStorage));
  locator.registerLazySingleton(() => MensaViewModel());
}
