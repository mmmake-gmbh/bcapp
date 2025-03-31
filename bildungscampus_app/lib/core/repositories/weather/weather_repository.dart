import 'package:bildungscampus_app/core/models/weather/weather_apigee.dart';

abstract class WeatherRepository {
  Future<WeatherApigee> getLatestWeather();
}
