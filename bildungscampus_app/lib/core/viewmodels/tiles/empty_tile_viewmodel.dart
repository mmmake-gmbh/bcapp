import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';

class EmptyTileViewModel extends BaseStartTileViewModel {
  EmptyTileViewModel({required super.type})
      : super(
          title: [],
          iconPath: '',
          navigationPath: '',
          maxTitleLines: 1,
          allowedUserType: UserType.notLoggedIn,
          featureType: FeatureType.empty,
          featureInfo: FeatureInfo(
            version: "",
            date: DateTime.now(),
            slides: [],
            isActive: false,
          ),
        );
}
