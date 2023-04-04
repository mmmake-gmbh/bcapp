import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

abstract class StartTilesRepository {
  Future<List<BaseStartTileViewModel>> allStartTiles();
}
