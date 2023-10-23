import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class WeatherTileViewModel extends BaseStartTileViewModel {
  final WeatherData weatherData;

  WeatherTileViewModel({
    required this.weatherData,
    required super.title,
    required super.iconPath,
    required super.type,
    required super.featureType,
    required super.featureInfo,
  }) : super(
            navigationPath: '',
            maxTitleLines: 1,
            allowedUserType: UserType.notLoggedIn);
}
