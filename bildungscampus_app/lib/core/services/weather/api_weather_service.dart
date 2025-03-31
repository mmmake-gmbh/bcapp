import 'dart:developer';

import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/core/repositories/weather/weather_repository.dart';
import 'package:bildungscampus_app/core/services/weather/weather_service.dart';
import 'package:bildungscampus_app/locator.dart';

class ApiWeatherService extends WeatherService {
  final WeatherRepository _weatherRepository = locator<WeatherRepository>();

  @override
  Future<WeatherData> getActualWeather() async {
    WeatherData result;

    try {
      final weatherData = await _weatherRepository.getLatestWeather();
      final outdoorTemp = weatherData.timeseries.outdoortemperature.firstOrNull;

      final temp = double.tryParse(outdoorTemp?.value ?? "0");

      result = WeatherData(value: temp ?? 0, unit: '°C');
    } catch (error) {
      log("WeatherService: $error");
      result = const WeatherData(
        value: 0,
        unit: '',
      );
    }

    return result;
  }
}
