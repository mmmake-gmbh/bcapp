import 'dart:developer' as dev;
import 'dart:math';

import 'package:bildungscampus_app/core/models/mensa/mensa_content.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_forecast_data.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/repositories/mensa/mensa_repository.dart';
import 'package:bildungscampus_app/core/utils/date_utils.dart';
import 'package:bildungscampus_app/locator.dart';

import 'base_viewmodel.dart';

class MensaViewModel extends BaseViewModel {
  final MensaRepository _mensaRepository = locator<MensaRepository>();

  MensaContent? _mensa;

  DayPlan? _selectedDayPlan;
  int? _initialDayPlanIndex;

  MensaMealPlan? get mensaMenu {
    if (_mensa?.menu == null) {
      return null;
    }

    final initialMensa = _mensa!.menu;
    final date = DateTime.now();
    final yesterday = _getDate(date).add(const Duration(days: -1));
    final thisSunday =
        _getDate(date.add(Duration(days: DateTime.daysPerWeek - date.weekday)));
    final nextMonday = thisSunday.add(const Duration(days: 8));
    final filteredPlan = initialMensa.tagesplan
        .where((plan) =>
            plan.datum.isAfter(yesterday) &&
            plan.datum.isBeforeDate(nextMonday))
        .toList();
    for (var dayPlan in filteredPlan) {
      dayPlan.linie?.sort((a, b) => a.ausgabe.index.compareTo(b.ausgabe.index));
    }

    return MensaMealPlan(ort: initialMensa.ort, tagesplan: filteredPlan);
  }

  DayPlan? get selectedDayPlan => _selectedDayPlan;

  int? get initialDayPlanIndex => _initialDayPlanIndex;
  List<MensaForecastData> get forecast {
    final now = DateTime.now();
    return _mensa?.forecast.data
            .where((d) =>
                d.time
                    .isAfter(DateTime(now.year, now.month, now.day, 11, 29)) &&
                d.time.isBefore(DateTime(now.year, now.month, now.day, 14, 31)))
            .toList() ??
        [];
  }

  int get maxforecast => max(
      forecast
          .map((d) => d.prediction)
          .reduce((curr, next) => curr > next ? curr : next),
      currentOccupancy);

  int get currentOccupancy => _mensa?.occupancy.currentOccupancy ?? 0;

  DateTime _getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  Future<void> load() async {
    try {
      _mensa = await _mensaRepository.getMensaContent();

      _selectedDayPlan = mensaMenu?.tagesplan
          .firstWhere((plan) => plan.datum.isSameDate(DateTime.now()));

      if (_selectedDayPlan != null) {
        _initialDayPlanIndex = mensaMenu?.tagesplan.indexOf(_selectedDayPlan!);
      }
    } catch (e) {
      dev.log('error during content load', error: e);
    }
  }

  void dayPlanSelected(DayPlan plan) {
    _selectedDayPlan = plan;
    notifyListeners();
  }
}
