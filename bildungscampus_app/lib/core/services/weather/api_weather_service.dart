import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/core/models/weather/weather_sensor.dart';
import 'package:bildungscampus_app/core/repositories/weather/weather_repository.dart';
import 'package:bildungscampus_app/core/services/weather/weather_service.dart';
import 'package:bildungscampus_app/locator.dart';

class ApiWeatherService extends WeatherService {
  WeatherRepository _weatherRepository = locator<WeatherRepository>();

  Future<WeatherData> getActualWeather() async {
    WeatherData result;

    try {
      final weatherData = await _weatherRepository.getLastestWeather();
      final temp = weatherData
          .firstWhere((x) => x!.sensor == WeatherSensorSensorEnum.temperature)!;

      final rain = weatherData
          .firstWhere((x) => x!.sensor == WeatherSensorSensorEnum.rain)!;

      result = WeatherData(
        value: temp.value,
        unit: temp.unit ?? '',
        isRaining: rain.value == 1,
      );
    } catch (error) {
      result = WeatherData(
        value: 0,
        unit: '',
      );
    }

    return result;
  }
}
