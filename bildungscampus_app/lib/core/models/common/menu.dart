import '../mensa/meal.dart';

class Menu {
  final int dayOfTheWeek;
  final List<Meal> meals;

  Menu({
    required this.dayOfTheWeek,
    required this.meals,
  });
}
