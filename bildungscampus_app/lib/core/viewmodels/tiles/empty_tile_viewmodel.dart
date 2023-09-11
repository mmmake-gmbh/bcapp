import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class EmptyTileViewModel extends BaseStartTileViewModel {
  EmptyTileViewModel({required type})
      : super(
            title: '',
            iconPath: '',
            navigationPath: '',
            type: type,
            maxTitleLines: 1);
}
