import 'package:bildungscampus_app/core/models/common/menu.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class MensaTileViewModel extends BaseStartTileViewModel {
  final List<Menu> weeklyMenu;

  MensaTileViewModel({
    required this.weeklyMenu,
    required title,
    required iconPath,
    required type,
  }) : super(
            title: title,
            iconPath: iconPath,
            navigationPath: '',
            type: type,
            maxTitleLines: 1);
}
