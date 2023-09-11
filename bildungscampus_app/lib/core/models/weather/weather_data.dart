import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';

class WeatherData {
  final double value;
  final String unit;
  final bool isRaining;

  const WeatherData({
    required this.value,
    required this.unit,
    this.isRaining = false,
  });

  String getWeatherText(BuildContext context) {
    if (value >= 31) {
      return isRaining
          ? S.of(context).weather_above31_raining
          : S.of(context).weather_above31;
    } else if (value < 31 && value >= 21) {
      return isRaining
          ? S.of(context).weather_between31and21_raining
          : S.of(context).weather_between31and21;
    } else if (value < 21 && value >= 11) {
      return isRaining
          ? S.of(context).weather_between21and11_raining
          : S.of(context).weather_between21and11;
    } else if (value < 11 && value >= 1) {
      return isRaining
          ? S.of(context).weather_between11and1_raining
          : S.of(context).weather_between11and1;
    } else {
      return isRaining
          ? S.of(context).weather_under1_raining
          : S.of(context).weather_under1;
    }
  }
}
