import 'package:bildungscampus_app/core/enums/tile_type.dart';
import 'package:bildungscampus_app/core/viewmodels/base_viewmodel.dart';

class BaseStartTileViewModel extends BaseViewModel {
  final String title;
  final String iconPath;
  final String navigationPath;
  final TileType type;
  final int maxTitleLines;

  BaseStartTileViewModel(
      {required this.title,
      required this.iconPath,
      required this.navigationPath,
      required this.type,
      required this.maxTitleLines});
}
