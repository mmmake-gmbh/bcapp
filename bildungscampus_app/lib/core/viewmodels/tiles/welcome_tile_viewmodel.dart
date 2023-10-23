import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/text_tile_viewmodel.dart';

class WelcomeTileViewModel extends TextTileViewModel {
  WelcomeTileViewModel({
    required super.description,
    super.buttonText,
    required super.navigationPath,
    required super.title,
    required super.iconPath,
    required super.type,
    required super.featureType,
    required super.featureInfo,
  }) : super(maxTitleLines: 2, allowedUserType: UserType.notLoggedIn);
}