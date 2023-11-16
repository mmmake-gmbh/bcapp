import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/models/common/app_menu.dart';
import 'package:bildungscampus_app/core/models/startscreen/tile.dart';
import 'package:bildungscampus_app/core/services/drawer/menu_service.dart';
import 'package:bildungscampus_app/ui/app_router.dart';

class CampusMenuService implements MenuService {
  @override
  AppMenu mapViewModel(TileV2 model) {
    switch (model.type) {
      case 'parking':
        return AppMenu(
          title: model.menuTitle,
          type: FeatureType.parking,
          allowedUserType: UserType.notLoggedIn,
          navigationPath: AppRouter.parkingRoute,
        );
      case 'timetable':
        return AppMenu(
          title: model.menuTitle,
          type: FeatureType.timeTable,
          allowedUserType: UserType.notLoggedIn,
          navigationPath: AppRouter.timetableRoute,
        );
      case 'locationmap':
        return AppMenu(
          title: model.menuTitle,
          type: FeatureType.locationMap,
          allowedUserType: UserType.notLoggedIn,
          navigationPath: AppRouter.locationMapRoute,
        );
      case 'booksearch':
        return AppMenu(
          title: model.menuTitle,
          type: FeatureType.bookSearch,
          allowedUserType: UserType.notLoggedIn,
          navigationPath: AppRouter.bookSearchRoute,
        );
      case 'payment':
        return AppMenu(
          title: model.menuTitle,
          type: FeatureType.payment,
          allowedUserType: UserType.notLoggedIn,
          navigationPath: AppRouter.paymentRoute,
        );
      case 'kienzler-bikes':
        return AppMenu(
          title: model.menuTitle,
          type: FeatureType.kienzlerBike,
          allowedUserType: UserType.notLoggedIn,
          navigationPath: AppRouter.kienzlerBikeRoute,
        );
      case 'fourtytwo':
        return AppMenu(
          title: model.menuTitle,
          type: FeatureType.fourtyTwo,
          allowedUserType: UserType.fourtyTwo,
          navigationPath: AppRouter.fourtyTwoRoute,
        );
      default:
        return AppMenu(
          title: model.menuTitle,
          type: FeatureType.home,
          allowedUserType: UserType.notLoggedIn,
          navigationPath: AppRouter.homeRoute,
        );
    }
  }
}
