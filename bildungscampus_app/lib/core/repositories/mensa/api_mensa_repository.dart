import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/repositories/base_repository.dart';
import 'package:bildungscampus_app/core/repositories/mensa/mensa_repository.dart';

class ApiMensaRepository extends BaseRepository<MensaMealPlan>
    implements MensaRepository {
  @override
  Future<MensaMealPlan> getMealPlan() async {
    final MensaMealPlan items = await getItem("/mensa");
    return items;
  }

  @override
  MensaMealPlan mapFromJson(jsonResponse) {
    return MensaMealPlan.fromJson(jsonResponse);
  }
}
