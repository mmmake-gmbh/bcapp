import 'package:bildungscampus_app/core/viewmodels/tiles/text_tile_viewmodel.dart';

class TimetableTileViewModel extends TextTileViewModel {
  TimetableTileViewModel({
    description,
    required buttonText,
    required navigationPath,
    required title,
    required iconPath,
    required type,
  }) : super(
          description: description,
          buttonText: buttonText,
          navigationPath: navigationPath,
          title: title,
          iconPath: iconPath,
          type: type,
          maxTitleLines: 2,
        );
}
