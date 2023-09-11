import 'package:bildungscampus_app/core/models/weather/weather_sensor.dart';
import 'package:bildungscampus_app/core/repositories/base_repository.dart';
import 'package:bildungscampus_app/core/repositories/weather/weather_repository.dart';

class ApiWeatherRepository extends BaseRepository<WeatherSensor>
    implements WeatherRepository {
  @override
  Future<List<WeatherSensor>> getLastestWeather() async {
    final List<WeatherSensor> items = await getItems("/weather");
    return items;
  }

  @override
  WeatherSensor mapFromJson(jsonResponse) {
    return WeatherSensor.fromJson(jsonResponse);
  }
}
