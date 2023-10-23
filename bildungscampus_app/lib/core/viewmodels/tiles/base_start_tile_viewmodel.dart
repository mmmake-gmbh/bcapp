import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/enums/tile_type.dart';
import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/viewmodels/base_viewmodel.dart';

class BaseStartTileViewModel extends BaseViewModel {
  final List<LocalizedText> title;
  final String iconPath;
  final String navigationPath;
  final TileType type;
  final FeatureType featureType;
  final int maxTitleLines;
  final UserType allowedUserType;
  final FeatureInfo featureInfo;

  BaseStartTileViewModel({
    required this.title,
    required this.iconPath,
    required this.navigationPath,
    required this.type,
    required this.featureType,
    required this.maxTitleLines,
    required this.allowedUserType,
    required this.featureInfo,
  });
}
