import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class ParkingTileViewModel extends BaseStartTileViewModel {
  final List<ParkingLotCategory> parkingCategories = [
    ParkingLotCategory.students,
    ParkingLotCategory.staff,
    ParkingLotCategory.guests,
  ];
  int _selectedIndex = 0;

  ParkingLotCategory? get selectedParkingCategory =>
      parkingCategories[_selectedIndex];

  ParkingTileViewModel({
    required super.title,
    required super.iconPath,
    required super.navigationPath,
    required super.type,
    required super.featureType,
    required super.featureInfo,
  }) : super(maxTitleLines: 2, allowedUserType: UserType.notLoggedIn);

  void updateSelectedParkinglot(int newIndex) {
    if (_selectedIndex != newIndex &&
        newIndex >= 0 &&
        newIndex < parkingCategories.length) {
      _selectedIndex = newIndex;
      notifyListeners();
    }
  }
}
