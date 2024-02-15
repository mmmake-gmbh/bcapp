import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/enums/tile_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/models/startscreen/app_content.dart';
import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/core/services/startscreen/tiles_service.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/bike_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/booksearch_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/campus_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/empty_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/fourty_two_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/locationmap_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/mensa_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/parking_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/payment_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/timetable_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/weather_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/welcome_tile_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';

class CampusTilesService implements TilesService {
  @override
  List<BaseStartTileViewModel> createViewModels(
    AppContentV2 model,
    WeatherData weatherData,
    BuildContext context,
  ) {
    final tiles = model.tiles.where((tile) => tile.visible);
    final returnList = tiles.map<BaseStartTileViewModel>((tileModel) {
      switch (tileModel.type) {
        case 'welcome':
          final vm = WelcomeTileViewModel(
            title: [],
            description: [],
            iconPath: 'iconPath',
            navigationPath: 'navigationPath',
            type: TileType.wideSmall,
            featureType: FeatureType.welcome,
            featureInfo: FeatureInfo(
              version: "",
              date: DateTime.now(),
              slides: [],
              isActive: false,
            ),
          );
          return vm;
        case 'weather':
          final vm = WeatherTileViewModel(
            title: tileModel.title,
            iconPath: '',
            weatherData: weatherData,
            type: TileType.small,
            featureType: FeatureType.weather,
            featureInfo: tileModel.featureInfo,
          );
          return vm;
        case 'mensa':
          final vm = MensaTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.mensa,
            description: tileModel.text,
            buttonText: S.of(context).tiles_button_text_more,
            navigationPath: AppRouter.mensaRoute,
            type: TileType.big,
            featureType: FeatureType.mensa,
            featureInfo: tileModel.featureInfo,
          );
          return vm;

        case 'parking':
          final vm = ParkingTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.parkinglot,
            description: tileModel.text,
            buttonText: S.of(context).tiles_button_text_more,
            navigationPath: AppRouter.parkingRoute,
            type: TileType.big,
            featureType: FeatureType.parking,
            featureInfo: tileModel.featureInfo,
          );
          return vm;
        case 'booksearch':
          final vm = BookSearchTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.bookSearch,
            description: tileModel.text,
            buttonText: S.of(context).tiles_button_text_more,
            navigationPath: AppRouter.bookSearchRoute,
            type: TileType.big,
            featureType: FeatureType.bookSearch,
            featureInfo: tileModel.featureInfo,
          );
          return vm;
        case 'payment':
          final vm = PaymentTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.campusCard,
            description: tileModel.text,
            buttonText: S.of(context).tiles_button_text_more,
            navigationPath: AppRouter.paymentRoute,
            type: TileType.big,
            featureType: FeatureType.payment,
            featureInfo: tileModel.featureInfo,
          );
          return vm;
        case 'timetable':
          final vm = TimetableTileViewModel(
            buttonText: S.of(context).tiles_button_text_show,
            navigationPath: AppRouter.timetableRoute,
            description: tileModel.text,
            title: tileModel.title,
            iconPath: SvgIcons.bus,
            type: TileType.big,
            featureType: FeatureType.timeTable,
            featureInfo: tileModel.featureInfo,
          );
          return vm;
        case 'locationmap':
          final vm = LocationMapTileViewModel(
            buttonText: S.of(context).tiles_button_text_show,
            navigationPath: AppRouter.locationMapRoute,
            description: tileModel.text,
            title: tileModel.title,
            iconPath: SvgIcons.pin,
            type: TileType.big,
            featureType: FeatureType.locationMap,
            featureInfo: tileModel.featureInfo,
          );
          return vm;
        case 'info':
          final vm = CampusTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.info,
            buttonText: S.of(context).tiles_button_text_more,
            description: tileModel.text,
            navigationPath: AppRouter.homeRoute,
            type: TileType.big,
            featureType: FeatureType.info,
            featureInfo: tileModel.featureInfo,
          );
          return vm;
        case 'fourtytwo':
          final vm = FourtytwoTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.school,
            buttonText: S.of(context).tiles_button_text_more,
            description: tileModel.text,
            navigationPath: AppRouter.fourtyTwoRoute,
            type: TileType.big,
            featureType: FeatureType.fourtyTwo,
            featureInfo: tileModel.featureInfo,
          );
          return vm;
        case 'kienzler-bikes':
          final vm = BikeTileViewModel(
            title: tileModel.title,
            iconPath: SvgIcons.bike,
            buttonText: S.of(context).tiles_button_text_more,
            description: tileModel.text,
            navigationPath: AppRouter.kienzlerBikeRoute,
            type: TileType.big,
            featureType: FeatureType.kienzlerBike,
            featureInfo: tileModel.featureInfo,
          );
          return vm;
        case 'placeholder':
          final vm = EmptyTileViewModel(
            type: TileType.small,
          );
          return vm;
        default:
          return EmptyTileViewModel(
            type: TileType.big,
          );
      }
    });

    return returnList.toList();
  }
}
