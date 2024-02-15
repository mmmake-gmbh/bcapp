import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';

abstract class MensaRepository {
  Future<MensaMealPlan> getMealPlan();
}
