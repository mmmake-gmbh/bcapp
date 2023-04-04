import 'dart:ui';

class DateUtils {
  static const List<String> _enDayOfTheWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  static const List<String> _deDayOfTheWeek = [
    'Montag',
    'Dienstag',
    'Mittwoch',
    'Donnerstag',
    'Freitag',
    'Samstag',
    'Sonntag'
  ];

  static String getDateOfTheWeek(Locale locale, int dayOfTheWeek) {
    if (dayOfTheWeek < 1 && dayOfTheWeek > 7) {
      return '';
    }

    switch (locale.languageCode.toLowerCase()) {
      case 'de':
        return _deDayOfTheWeek[dayOfTheWeek - 1];
      case 'en':
        return _enDayOfTheWeek[dayOfTheWeek - 1];
      default:
        return '';
    }
  }
}
