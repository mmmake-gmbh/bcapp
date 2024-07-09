import 'package:bildungscampus_app/core/models/mensa/mensa_content.dart';

abstract class MensaRepository {
  Future<MensaContent> getMensaContent();
}
