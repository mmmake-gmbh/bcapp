import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class WeatherTileViewModel extends BaseStartTileViewModel {
  final WeatherData weatherData;

  WeatherTileViewModel({
    required this.weatherData,
    title,
    iconPath,
    required type,
  }) : super(
          title: title,
          iconPath: iconPath,
          navigationPath: '',
          type: type,
          maxTitleLines: 1,
        );
}
