import 'package:bildungscampus_app/core/enums/tile_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/startscreen/app_content.dart';
import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/core/services/startscreen/tiles_service.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/booksearch_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/campus_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/empty_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/locationmap_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/mensa_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/parking_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/payment_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/timetable_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/weather_tile_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';

class CampusTilesService implements TilesService {
  @override
  List<BaseStartTileViewModel> createViewModels(
    AppContent model,
    WeatherData weatherData,
    BuildContext context,
  ) {
    final tiles = model.tiles.where((tile) => tile.visible);
    final returnList = tiles.map<BaseStartTileViewModel>((tileModel) {
      switch (tileModel.type) {
        case 'weather':
          final vm = WeatherTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.weather,
            weatherData: weatherData,
            type: TileType.Small,
          );
          return vm;
        case 'mensa':
          final vm = MensaTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.mensa,
            weeklyMenu: [], //TODO: Mensa
            type: TileType.Big,
          );
          return vm;
        case 'parking':
          final vm = ParkingTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.parkinglot,
            navigationPath: AppRouter.parkingRoute,
            type: TileType.Big,
          );
          return vm;
        case 'booksearch':
          final vm = BookSearchTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.bookSearch,
            description: tileModel.text,
            buttonText: S.of(context).tiles_button_text_more,
            navigationPath: AppRouter.bookSearchRoute,
            type: TileType.Big,
          );
          return vm;
        case 'payment':
          final vm = PaymentTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.campusCard,
            description: tileModel.text,
            buttonText: S.of(context).tiles_button_text_more,
            navigationPath: AppRouter.paymentRoute,
            type: TileType.Big,
          );
          return vm;
        case 'timetable':
          final vm = TimetableTileViewModel(
            buttonText: S.of(context).tiles_button_text_show,
            navigationPath: AppRouter.timetableRoute,
            description: tileModel.text,
            title: tileModel.title,
            iconPath: SvgIcons.bus,
            type: TileType.Big,
          );
          return vm;
        case 'locationmap':
          final vm = LocationMapTileViewModel(
            buttonText: S.of(context).tiles_button_text_show,
            navigationPath: AppRouter.locationMapRoute,
            description: tileModel.text,
            title: tileModel.title,
            iconPath: SvgIcons.pin,
            type: TileType.Wide,
          );
          return vm;
        case 'info':
          final vm = CampusTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.info,
            buttonText: S.of(context).tiles_button_text_more,
            description: tileModel.text,
            navigationPath: AppRouter.homeRoute,
            type: TileType.Big,
          );
          return vm;
        case 'placeholder':
          final vm = EmptyTileViewModel(
            type: TileType.Small,
          );
          return vm;
        default:
          return EmptyTileViewModel(
            type: TileType.Big,
          );
      }
    });

    return returnList.toList();
  }
}
