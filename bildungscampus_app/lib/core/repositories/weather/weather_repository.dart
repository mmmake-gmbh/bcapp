import 'package:bildungscampus_app/core/models/weather/weather_sensor.dart';

abstract class WeatherRepository {
  Future<List<WeatherSensor?>> getLastestWeather();
}
