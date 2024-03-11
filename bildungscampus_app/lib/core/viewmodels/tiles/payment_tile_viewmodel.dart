import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/text_tile_viewmodel.dart';

class PaymentTileViewModel extends TextTileViewModel {
  PaymentTileViewModel({
    required super.description,
    super.buttonText,
    required super.navigationPath,
    required super.title,
    required super.icon,
    required super.type,
    required super.featureType,
    required super.featureInfo,
  }) : super(maxTitleLines: 1, allowedUserType: UserType.notLoggedIn);
}
