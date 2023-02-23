import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class ParkingTileViewModel extends BaseStartTileViewModel {
  final List<MapEntry<ParkingLotCategory, String>> parkingCategories = [
    MapEntry(ParkingLotCategory.Students, 'für Studierende'),
    MapEntry(ParkingLotCategory.Staff, 'für Beschäftigte'),
    MapEntry(ParkingLotCategory.Guests, 'für Besucher:innen'),
  ];
  int _selectedIndex = 0;

  MapEntry<ParkingLotCategory, String>? get selectedParkingCategory =>
      parkingCategories[_selectedIndex];

  ParkingTileViewModel({
    required title,
    required iconPath,
    required navigationPath,
    required type,
  }) : super(
            title: title,
            iconPath: iconPath,
            navigationPath: navigationPath,
            type: type,
            maxTitleLines: 2);

  void updateSelectedParkinglot(int newIndex) {
    if (_selectedIndex != newIndex &&
        newIndex >= 0 &&
        newIndex < parkingCategories.length) {
      _selectedIndex = newIndex;
      notifyListeners();
    }
  }
}
