import 'package:bildungscampus_app/core/models/startscreen/app_content.dart';
import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:flutter/material.dart';

abstract class TilesService {
  List<BaseStartTileViewModel> createViewModels(
      AppContent model, WeatherData weatherData, BuildContext context);
}
