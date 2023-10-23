import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';

class AppMenu {
  final List<LocalizedText> title;
  final String? simpleTitle;
  final FeatureType type;
  final String? navigationPath;
  final String? externalPath;
  final UserType allowedUserType;

  AppMenu({
    required this.title,
    required this.type,
    required this.allowedUserType,
    this.simpleTitle,
    this.navigationPath,
    this.externalPath,
  });
}
