import 'dart:developer';

import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/repositories/mensa/mensa_repository.dart';
import 'package:bildungscampus_app/core/utils/date_utils.dart';
import 'package:bildungscampus_app/locator.dart';

import 'base_viewmodel.dart';

class MensaViewModel extends BaseViewModel {
  final MensaRepository _mensaRepository = locator<MensaRepository>();

  MensaMealPlan? _mensa;

  DayPlan? _selectedDayPlan;
  int? _initialDayPlanIndex;

  MensaMealPlan? get mensa => _mensa;
  DayPlan? get selectedDayPlan => _selectedDayPlan;
  int? get initialDayPlanIndex => _initialDayPlanIndex;

  Future<void> load() async {
    try {
      final mensa = await _mensaRepository.getMealPlan();

      _mensa = mensa;
      _selectedDayPlan = mensa.tagesplan
          .firstWhere((plan) => plan.datum.isSameDate(DateTime.now()));

      if (_selectedDayPlan != null) {
        _initialDayPlanIndex = mensa.tagesplan.indexOf(_selectedDayPlan!);
      }
    } catch (e) {
      log('error during content load', error: e);
    }
  }

  void dayPlanSelected(DayPlan plan) {
    _selectedDayPlan = plan;
    notifyListeners();
  }
}
