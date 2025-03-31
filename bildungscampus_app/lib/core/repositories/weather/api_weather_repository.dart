import 'package:bildungscampus_app/core/models/weather/weather_apigee.dart';
import 'package:bildungscampus_app/core/repositories/base_repository.dart';
import 'package:bildungscampus_app/core/repositories/weather/weather_repository.dart';

class ApiWeatherRepository extends BaseRepository<WeatherApigee>
    implements WeatherRepository {
  @override
  Future<WeatherApigee> getLatestWeather() async {
    final item = await getItem("/weather-v2");
    return item;
  }

  @override
  WeatherApigee mapFromJson(jsonResponse) {
    return WeatherApigee.fromJson(jsonResponse);
  }
}
