class WeatherData {
  final double value;
  final String unit;
  final bool isRaining;

  const WeatherData({
    required this.value,
    required this.unit,
    this.isRaining = false,
  });
}
