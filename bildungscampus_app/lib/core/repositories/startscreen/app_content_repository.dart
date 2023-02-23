import 'package:bildungscampus_app/core/models/startscreen/app_content.dart';

abstract class AppContentRepository {
  Future<AppContent> getAll();
}
