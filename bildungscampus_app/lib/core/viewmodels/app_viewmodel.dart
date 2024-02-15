import 'dart:developer';

import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/enums/viewstate.dart';
import 'package:bildungscampus_app/core/models/common/app_menu.dart';
import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/models/info/campus_info.dart';
import 'package:bildungscampus_app/core/models/info/contact_info.dart';
import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/core/models/startscreen/app_content.dart';
import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/core/repositories/startscreen/app_content_repository.dart';
import 'package:bildungscampus_app/core/services/drawer/menu_service.dart';
import 'package:bildungscampus_app/core/services/startscreen/tiles_service.dart';
import 'package:bildungscampus_app/core/services/weather/weather_service.dart';
import 'package:bildungscampus_app/core/utils/string_utils.dart';
import 'package:bildungscampus_app/core/utils/user_type_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/parking/parkinglot_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'base_viewmodel.dart';

class AppViewModel extends BaseViewModel {
  static const String locationMapKey = 'Lageplan';
  static const String timeTableLinkKey = 'Abfahrtsmonitor';
  static const String campusRadLinkKey = 'CampusRad';
  static const String zeagLinkKey = 'Zeag';
  static const String bookSearchLinkKey = 'Buchsuche';
  static const String paymentKey = 'CampusCard';
  static const String accountSettingLinkKey = 'Benutzerkonto';
  static const String sessionsSettingLinkKey = 'Anmeldungen';
  static const String campusCardSettingLinkKey = 'CampusCardSetting';
  static const String gitHubLinkKey = 'GitHub';
  static const String fahrradBoxLinkKey = 'FahrradBox';

  final AppContentRepository _contentRepository =
      locator<AppContentRepository>();
  final WeatherService _weatherService = locator<WeatherService>();
  final TilesService _tilesService = locator<TilesService>();
  final MenuService _menuService = locator<MenuService>();
  late FlutterSecureStorage _secureStorage;

  List<BaseStartTileViewModel>? _tiles;
  List<AppMenu>? _mainMenu;
  List<ParkingLotViewModel>? _parkingLots;
  ContactInfoV2? _contactInfo;
  CampusInfoV2? _campusInfo;
  List<ExternalLink>? _externalLinks;
  WeatherData? _currentWeather;
  FeatureInfo? _overallFeatureInfo;

  List<BaseStartTileViewModel>? get tiles => _tiles;
  List<AppMenu>? get mainMenu => _mainMenu;
  ContactInfoV2? get contactInfo => _contactInfo;
  CampusInfoV2? get campusInfo => _campusInfo;
  List<ExternalLink>? get externalLinks => _externalLinks;
  WeatherData? get currentWeather => _currentWeather;
  FeatureInfo get overallFeatureInfo =>
      _overallFeatureInfo ??
      FeatureInfo(
          slides: [], version: "", isActive: false, date: DateTime.now());

  String? get locationMapLink => _externalLinkByKey(locationMapKey);
  String? get timeTableLink => _externalLinkByKey(timeTableLinkKey);
  String? get campusRadLink => _externalLinkByKey(campusRadLinkKey);
  String? get zaegLink => _externalLinkByKey(zeagLinkKey);
  String? get bookSearchLink => _externalLinkByKey(bookSearchLinkKey);
  String? get paymentLink => _externalLinkByKey(paymentKey);
  String? get accountSettingLink => _externalLinkByKey(accountSettingLinkKey);
  String? get sessionsSettingLink => _externalLinkByKey(sessionsSettingLinkKey);
  String? get campusCardSettingLink =>
      _externalLinkByKey(campusCardSettingLinkKey);
  String? get gitHubLink => _externalLinkByKey(gitHubLinkKey);
  String? get fahradBoxLink => _externalLinkByKey(fahrradBoxLinkKey);

  AppViewModel(FlutterSecureStorage storage) {
    _secureStorage = storage;
  }

  Future<void> load(BuildContext context) async {
    setState(ViewState.busy);
    try {
      final user = context.read<UserViewModel>();
      final content = await _contentRepository.getAll();
      final weather = await _weatherService.getActualWeather();

      if (context.mounted) {
        updateAppContent(
          content: content,
          weather: weather,
          user: user,
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
      final user = context.read<UserViewModel>();
      final content = await _contentRepository.getAll();
      final weather = await _weatherService.getActualWeather();

      if (context.mounted) {
        updateAppContent(
          content: content,
          weather: weather,
          user: user,
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
    required AppContentV2 content,
    required WeatherData weather,
    required UserViewModel user,
    required BuildContext context,
    bool updateAll = false,
  }) {
    _currentWeather = weather;
    _parkingLots = content.parkingLots
        .map((model) => ParkingLotViewModel(parkingLot: model))
        .toList();
    if (updateAll) {
      _tiles = _tilesService
          .createViewModels(content, weather, context)
          .where((tile) => UserTypeUtils.isUserTypedAllowed(
              tile.allowedUserType, user.userType))
          .toList();

      final menu = content.tiles.where((tile) => tile.showInMenu).toList();
      menu.sort((a, b) => a.menuOrder.compareTo(b.menuOrder));

      _mainMenu = menu
          .map((menu) => _menuService.mapViewModel(menu))
          .where((menu) => UserTypeUtils.isUserTypedAllowed(
              menu.allowedUserType, user.userType))
          .toList();
      _contactInfo = content.contactInfo;
      _campusInfo = content.campusInfo;
      _externalLinks = content.externalLinks;
      _overallFeatureInfo = content.featureInfo;
    }
  }

  List<LocalizedText> getAppMenuTitle(FeatureType type) {
    if (_mainMenu != null &&
        _mainMenu!.any((element) => element.type == type)) {
      final selectedMainMenu =
          _mainMenu!.firstWhere((elem) => elem.type == type);
      return selectedMainMenu.title;
    }
    return [];
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

  String? _externalLinkByKey(String key) {
    if (_externalLinks != null &&
        _externalLinks!.any((link) => link.name == key)) {
      return externalLinks!.firstWhere((link) => link.name == key).link;
    }
    return null;
  }

  Future<void> saveFeatureInfoReadStatus(
      FeatureType type, FeatureInfo featureInfo) async {
    final key = _getFeatureInfoKey(type, featureInfo);
    await _secureStorage.write(key: key, value: "false");
  }

  Future<bool> shouldShowFeatureInfo(
      FeatureType type, FeatureInfo? featureInfo) async {
    if (featureInfo == null) {
      return false;
    }

    final packageInfo = await PackageInfo.fromPlatform();

    if (!StringUtils.isNewestVersion(
            featureInfo.version, packageInfo.version) ||
        !featureInfo.isActive) {
      return false;
    }

    final key = _getFeatureInfoKey(type, featureInfo);
    final value = await _secureStorage.read(key: key);
    return bool.parse(value ?? "true");
  }

  String _getFeatureInfoKey(FeatureType type, FeatureInfo featureInfo) {
    return "${StringUtils.enumName(type.toString())}-${featureInfo.version}-${featureInfo.date.toIso8601String()}";
  }
}
