import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class TextTileViewModel extends BaseStartTileViewModel {
  final List<LocalizedText> description;
  final String? buttonText;

  TextTileViewModel({
    required this.description,
    this.buttonText,
    required super.navigationPath,
    required super.title,
    required super.icon,
    required super.type,
    required super.featureType,
    required super.maxTitleLines,
    required super.allowedUserType,
    required super.featureInfo,
  });
}
