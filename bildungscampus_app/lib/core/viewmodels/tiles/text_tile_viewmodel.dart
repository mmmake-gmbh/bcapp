import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class TextTileViewModel extends BaseStartTileViewModel {
  final String? description;
  final String? buttonText;

  TextTileViewModel({
    required this.description,
    this.buttonText,
    required navigationPath,
    required title,
    required iconPath,
    required type,
    required maxTitleLines,
  }) : super(
            title: title,
            iconPath: iconPath,
            navigationPath: navigationPath,
            type: type,
            maxTitleLines: maxTitleLines);
}
