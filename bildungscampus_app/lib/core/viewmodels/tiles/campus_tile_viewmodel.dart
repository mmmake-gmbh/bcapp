import 'package:bildungscampus_app/core/viewmodels/tiles/text_tile_viewmodel.dart';

class CampusTileViewModel extends TextTileViewModel {
  CampusTileViewModel({
    description,
    buttonText,
    navigationPath,
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
          maxTitleLines: 1,
        );
}
