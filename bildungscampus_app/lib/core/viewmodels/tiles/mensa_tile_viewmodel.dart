import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/models/common/menu.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class MensaTileViewModel extends BaseStartTileViewModel {
  final List<Menu> weeklyMenu;

  MensaTileViewModel({
    required this.weeklyMenu,
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
