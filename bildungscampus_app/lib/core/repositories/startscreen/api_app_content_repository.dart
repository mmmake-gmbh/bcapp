import 'package:bildungscampus_app/core/models/startscreen/app_content.dart';
import 'package:bildungscampus_app/core/repositories/base_repository.dart';
import 'package:bildungscampus_app/core/repositories/startscreen/app_content_repository.dart';

class ApiAppContentRepository extends BaseRepository<AppContent>
    implements AppContentRepository {
  @override
  Future<AppContent> getAll() async {
    final AppContent items = await getItem("/content");
    return Future.value(items);
  }

  @override
  AppContent mapFromJson(jsonResponse) {
    return AppContent.fromJson(jsonResponse);
  }
}
