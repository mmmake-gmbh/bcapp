import 'package:bildungscampus_app/core/models/startscreen/app_content.dart';
import 'package:bildungscampus_app/core/repositories/base_repository.dart';
import 'package:bildungscampus_app/core/repositories/startscreen/app_content_repository.dart';

class ApiAppContentRepository extends BaseRepository<AppContentV2>
    implements AppContentRepository {
  @override
  Future<AppContentV2> getAll() async {
    final AppContentV2 items = await getItem("/content-v2");
    return Future.value(items);
  }

  @override
  AppContentV2 mapFromJson(jsonResponse) {
    return AppContentV2.fromJson(jsonResponse);
  }
}
