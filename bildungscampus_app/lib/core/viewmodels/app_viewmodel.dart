import 'dart:developer';

import 'package:bildungscampus_app/core/enums/app_menu_type.dart';
import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/enums/viewstate.dart';
import 'package:bildungscampus_app/core/models/common/app_menu.dart';
import 'package:bildungscampus_app/core/models/info/campus_info.dart';
import 'package:bildungscampus_app/core/models/info/contact_info.dart';
import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/core/models/startscreen/app_content.dart';
import 'package:bildungscampus_app/core/models/startscreen/tile.dart';
import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/core/repositories/startscreen/app_content_repository.dart';
import 'package:bildungscampus_app/core/services/startscreen/tiles_service.dart';
import 'package:bildungscampus_app/core/services/weather/weather_service.dart';
import 'package:bildungscampus_app/core/viewmodels/parking/parkinglot_viewmodel.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:flutter/material.dart';
import 'base_viewmodel.dart';

class AppViewModel extends BaseViewModel {
  static const String locationMapKey = 'Lageplan';
  static const String timeTableLinkKey = 'Abfahrtsmonitor';
  static const String campusRadLinkKey = 'CampusRad';
  static const String zeagLinkKey = 'Zeag';
  static const String bookSearchKey = 'Buchsuche';
  static const String paymentKey = 'CampusCard';

  final AppContentRepository _contentRepository =
      locator<AppContentRepository>();
  final WeatherService _weatherService = locator<WeatherService>();
  final TilesService _tilesService = locator<TilesService>();

  List<BaseViewModel>? _tiles;
  List<AppMenu>? _mainMenu;
  List<ParkingLotViewModel>? _parkingLots;
  ContactInfo? _contactInfo;
  CampusInfo? _campusInfo;
  List<ExternalLink>? _externalLinks;
  WeatherData? _currentWeather;

  List<BaseViewModel>? get tiles => _tiles;
  List<AppMenu>? get mainMenu => _mainMenu;
  ContactInfo? get contactInfo => _contactInfo;
  CampusInfo? get campusInfo => _campusInfo;
  List<ExternalLink>? get externalLinks => _externalLinks;
  WeatherData? get currentWeather => _currentWeather;

  String? get locationMapLink => _externalLinkByKey(locationMapKey);
  String? get timeTableLink => _externalLinkByKey(timeTableLinkKey);
  String? get campusRadLink => _externalLinkByKey(campusRadLinkKey);
  String? get zaegLink => _externalLinkByKey(zeagLinkKey);
  String? get bookSearchLink => _externalLinkByKey(bookSearchKey);
  String? get paymentLink => _externalLinkByKey(paymentKey);

  Future<void> load(BuildContext context) async {
    setState(ViewState.busy);
    try {
      final content = await _contentRepository.getAll();
      final weather = await _weatherService.getActualWeather();

      if (context.mounted) {
        updateAppContent(
          content: content,
          weather: weather,
          updateAll: true,
          context: context,
        );

        setState(ViewState.ready);
      }
    } catch (e) {
      log('error during content load', error: e);
      setState(ViewState.error);
    }
  }

  Future<void> updateSilently(BuildContext context,
      {bool updateAll = false}) async {
    log('Updating silently');
    try {
      final content = await _contentRepository.getAll();
      final weather = await _weatherService.getActualWeather();

      if (context.mounted) {
        updateAppContent(
          content: content,
          weather: weather,
          updateAll: updateAll,
          context: context,
        );

        notifyListeners();
      }
    } catch (e) {
      log('error during silently content load', error: e);
    }
  }

  void updateAppContent({
    required AppContent content,
    required WeatherData weather,
    required BuildContext context,
    bool updateAll = false,
  }) {
    _currentWeather = weather;
    _parkingLots = content.parkingLots
        .map((model) => ParkingLotViewModel(parkingLot: model))
        .toList();
    if (updateAll) {
      _tiles = _tilesService.createViewModels(content, weather, context);

      final menu = content.tiles.where((tile) => tile.showInMenu).toList();
      menu.sort((a, b) => a.menuOrder.compareTo(b.menuOrder));

      _mainMenu = menu.map((menu) => _mapAppMenu(menu)).toList();
      _contactInfo = content.contactInfo;
      _campusInfo = content.campusInfo;
      _externalLinks = content.externalLinks;
    }
  }

  String? getAppMenuTitle(AppMenuType type) {
    if (_mainMenu != null &&
        _mainMenu!.any((element) => element.type == type)) {
      final selectedMainMenu =
          _mainMenu!.firstWhere((elem) => elem.type == type);
      return selectedMainMenu.title;
    }
    return null;
  }

  List<ParkingLotViewModel> getParkingLotsByCategory(
      ParkingLotCategory category) {
    if (_parkingLots == null) {
      return [];
    }
    final parkingLots = _parkingLots!
        .where((vm) =>
            vm.parkingLot.categories.any((element) => element == category))
        .toList();

    return parkingLots;
  }

  AppMenu _mapAppMenu(Tile model) {
    switch (model.type) {
      case 'parking':
        return AppMenu(
          title: model.menuTitle,
          type: AppMenuType.parking,
          navigationPath: AppRouter.parkingRoute,
        );
      case 'timetable':
        return AppMenu(
          title: model.menuTitle,
          type: AppMenuType.timeTable,
          navigationPath: AppRouter.timetableRoute,
        );
      case 'locationmap':
        return AppMenu(
          title: model.menuTitle,
          type: AppMenuType.locationMap,
          navigationPath: AppRouter.locationMapRoute,
        );
      case 'booksearch':
        return AppMenu(
          title: model.menuTitle,
          type: AppMenuType.bookSearch,
          navigationPath: AppRouter.bookSearchRoute,
        );
      case 'payment':
        return AppMenu(
          title: model.menuTitle,
          type: AppMenuType.payment,
          navigationPath: AppRouter.paymentRoute,
        );
      default:
        return AppMenu(
          title: model.menuTitle,
          type: AppMenuType.home,
          navigationPath: AppRouter.homeRoute,
        );
    }
  }

  String? _externalLinkByKey(String key) {
    if (_externalLinks != null &&
        _externalLinks!.any((link) => link.name == key)) {
      return externalLinks!.firstWhere((link) => link.name == key).link;
    }
    return null;
  }
}
