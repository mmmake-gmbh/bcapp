import 'package:bildungscampus_app/core/models/mensa/mensa_content.dart';
import 'package:bildungscampus_app/core/repositories/base_repository.dart';
import 'package:bildungscampus_app/core/repositories/mensa/mensa_repository.dart';

class ApiMensaRepository extends BaseRepository<MensaContent>
    implements MensaRepository {
  @override
  Future<MensaContent> getMensaContent() async {
    final MensaContent item = await getItem("/content-mensa");
    return item;
  }

  @override
  MensaContent mapFromJson(jsonResponse) {
    return MensaContent.fromJson(jsonResponse);
  }
}
