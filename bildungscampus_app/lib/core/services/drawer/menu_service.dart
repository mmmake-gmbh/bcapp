import 'package:bildungscampus_app/core/models/common/app_menu.dart';
import 'package:bildungscampus_app/core/models/startscreen/tile.dart';

abstract class MenuService {
  AppMenu mapViewModel(TileV2 model);
}
