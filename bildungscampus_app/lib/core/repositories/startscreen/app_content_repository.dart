import 'package:bildungscampus_app/core/models/startscreen/app_content.dart';

abstract class AppContentRepository {
  Future<AppContentV2> getAll();
}
