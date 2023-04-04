import 'package:bildungscampus_app/core/repositories/startscreen/api_app_content_repository.dart';
import 'package:bildungscampus_app/core/repositories/startscreen/app_content_repository.dart';
import 'package:bildungscampus_app/core/services/weather/api_weather_service.dart';
import 'package:bildungscampus_app/core/services/weather/weather_service.dart';
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

void setupLocator() {
  locator.registerLazySingleton<TilesService>(() => CampusTilesService());
  locator.registerLazySingleton<AuthService>(() => OAuthAuthService());
  locator.registerLazySingleton<SettingsService>(() => LocalSettingsService());
  locator
      .registerLazySingleton<WeatherRepository>(() => ApiWeatherRepository());
  locator.registerLazySingleton<IntroRepository>(() => LocalIntroRepository());
  locator.registerLazySingleton<AppContentRepository>(
      () => ApiAppContentRepository());
  locator.registerLazySingleton<WeatherService>(() => ApiWeatherService());
  locator.registerLazySingleton(() => AppViewModel());
  locator.registerLazySingleton<PrivacyViewModel>(() => PrivacyViewModel());
}
