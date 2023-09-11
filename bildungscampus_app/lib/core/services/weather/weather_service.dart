import 'package:bildungscampus_app/core/models/weather/weather_data.dart';

abstract class WeatherService {
  Future<WeatherData> getActualWeather();
}
