import 'package:bildungscampus_app/core/enums/app_menu_type.dart';

class AppMenu {
  final String title;
  final AppMenuType type;
  final String? navigationPath;
  final String? externalPath;

  AppMenu({
    required this.title,
    required this.type,
    this.navigationPath,
    this.externalPath,
  });
}
