// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Heute schwül-warme`
  String get weather_above31_raining {
    return Intl.message(
      'Heute schwül-warme',
      name: 'weather_above31_raining',
      desc: '',
      args: [],
    );
  }

  /// `Heute tropische`
  String get weather_above31 {
    return Intl.message(
      'Heute tropische',
      name: 'weather_above31',
      desc: '',
      args: [],
    );
  }

  /// `Heute feucht-fröhliche`
  String get weather_between31and21_raining {
    return Intl.message(
      'Heute feucht-fröhliche',
      name: 'weather_between31and21_raining',
      desc: '',
      args: [],
    );
  }

  /// `Heute sommerliche`
  String get weather_between31and21 {
    return Intl.message(
      'Heute sommerliche',
      name: 'weather_between31and21',
      desc: '',
      args: [],
    );
  }

  /// `Heute nass-milde`
  String get weather_between21and11_raining {
    return Intl.message(
      'Heute nass-milde',
      name: 'weather_between21and11_raining',
      desc: '',
      args: [],
    );
  }

  /// `Heute milde`
  String get weather_between21and11 {
    return Intl.message(
      'Heute milde',
      name: 'weather_between21and11',
      desc: '',
      args: [],
    );
  }

  /// `Heute klamm-kühle`
  String get weather_between11and1_raining {
    return Intl.message(
      'Heute klamm-kühle',
      name: 'weather_between11and1_raining',
      desc: '',
      args: [],
    );
  }

  /// `Heute coole`
  String get weather_between11and1 {
    return Intl.message(
      'Heute coole',
      name: 'weather_between11and1',
      desc: '',
      args: [],
    );
  }

  /// `Heute ungemütlich-kalte`
  String get weather_under1_raining {
    return Intl.message(
      'Heute ungemütlich-kalte',
      name: 'weather_under1_raining',
      desc: '',
      args: [],
    );
  }

  /// `Heute eiskalte`
  String get weather_under1 {
    return Intl.message(
      'Heute eiskalte',
      name: 'weather_under1',
      desc: '',
      args: [],
    );
  }

  /// `Bibliothek`
  String get maps_building15_name {
    return Intl.message(
      'Bibliothek',
      name: 'maps_building15_name',
      desc: '',
      args: [],
    );
  }

  /// `Aula`
  String get maps_building6_name {
    return Intl.message(
      'Aula',
      name: 'maps_building6_name',
      desc: '',
      args: [],
    );
  }

  /// `Mensa`
  String get maps_building8_name {
    return Intl.message(
      'Mensa',
      name: 'maps_building8_name',
      desc: '',
      args: [],
    );
  }

  /// `"Mein Bildungscampus" — der digitale Campus an einem Ort und jederzeit griffbereit:`
  String get intro_overview_title {
    return Intl.message(
      '"Mein Bildungscampus" — der digitale Campus an einem Ort und jederzeit griffbereit:',
      name: 'intro_overview_title',
      desc: '',
      args: [],
    );
  }

  /// `"Mein Bildungscampus" — der digitale Campus an einem Ort und jederzeit griffbereit:`
  String get intro_overview2_title {
    return Intl.message(
      '"Mein Bildungscampus" — der digitale Campus an einem Ort und jederzeit griffbereit:',
      name: 'intro_overview2_title',
      desc: '',
      args: [],
    );
  }

  /// `An den Campus fahren oder Alternativen planen?`
  String get intro_parkinglot_title {
    return Intl.message(
      'An den Campus fahren oder Alternativen planen?',
      name: 'intro_parkinglot_title',
      desc: '',
      args: [],
    );
  }

  /// `Die Auslastung der Parkplätze wird dir hier in Echtzeit angegeben.`
  String get intro_parkinglot_subtitle {
    return Intl.message(
      'Die Auslastung der Parkplätze wird dir hier in Echtzeit angegeben.',
      name: 'intro_parkinglot_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Wann fährt der nächste Bus?`
  String get intro_timetable_title {
    return Intl.message(
      'Wann fährt der nächste Bus?',
      name: 'intro_timetable_title',
      desc: '',
      args: [],
    );
  }

  /// `Mit dem Abfahrtsmonitor erreichst du auf die Minute genau alle Abfahrten von Bus und Bahn rund um den Bildungscampus.`
  String get intro_timetable_subtitle {
    return Intl.message(
      'Mit dem Abfahrtsmonitor erreichst du auf die Minute genau alle Abfahrten von Bus und Bahn rund um den Bildungscampus.',
      name: 'intro_timetable_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Wo finde ich die passende Literatur für die nächste Hausarbeit?`
  String get intro_booksearch_title {
    return Intl.message(
      'Wo finde ich die passende Literatur für die nächste Hausarbeit?',
      name: 'intro_booksearch_title',
      desc: '',
      args: [],
    );
  }

  /// `Im Online-Katalog der Bibliothek LIV findest du viele verschiedene Medien zur Ansicht und Ausleihe.`
  String get intro_booksearch_subtitle {
    return Intl.message(
      'Im Online-Katalog der Bibliothek LIV findest du viele verschiedene Medien zur Ansicht und Ausleihe.',
      name: 'intro_booksearch_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Wie kann ich meine CampusCard aufladen?`
  String get intro_payment_title {
    return Intl.message(
      'Wie kann ich meine CampusCard aufladen?',
      name: 'intro_payment_title',
      desc: '',
      args: [],
    );
  }

  /// `Wie finde ich mich auf dem Campus zurecht? `
  String get intro_map_title {
    return Intl.message(
      'Wie finde ich mich auf dem Campus zurecht? ',
      name: 'intro_map_title',
      desc: '',
      args: [],
    );
  }

  /// `Auf dem Lageplan sind Gebäude, Institutionen, Parkmöglichkeiten, Gastronomie, Services und Veranstaltungsbereiche verortet.`
  String get intro_map_subtitle {
    return Intl.message(
      'Auf dem Lageplan sind Gebäude, Institutionen, Parkmöglichkeiten, Gastronomie, Services und Veranstaltungsbereiche verortet.',
      name: 'intro_map_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Über das PaymentPortal lässt sich die CampusCard komfortabel online verwalten und aufladen \u2014 immer und überall nur einen Klick entfernt.`
  String get intro_payment_subtitle {
    return Intl.message(
      'Über das PaymentPortal lässt sich die CampusCard komfortabel online verwalten und aufladen \\u2014 immer und überall nur einen Klick entfernt.',
      name: 'intro_payment_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Intro beenden`
  String get intro_view_stop_intro {
    return Intl.message(
      'Intro beenden',
      name: 'intro_view_stop_intro',
      desc: '',
      args: [],
    );
  }

  /// `Intro überspringen`
  String get intro_view_skip_intro {
    return Intl.message(
      'Intro überspringen',
      name: 'intro_view_skip_intro',
      desc: '',
      args: [],
    );
  }

  /// `Mit der Nutzung der App werden die `
  String get intro_view_term_of_use_part1 {
    return Intl.message(
      'Mit der Nutzung der App werden die ',
      name: 'intro_view_term_of_use_part1',
      desc: '',
      args: [],
    );
  }

  /// `Nutzungsbedingungen`
  String get intro_view_term_of_use_part2 {
    return Intl.message(
      'Nutzungsbedingungen',
      name: 'intro_view_term_of_use_part2',
      desc: '',
      args: [],
    );
  }

  /// ` und die `
  String get intro_view_term_of_use_part3 {
    return Intl.message(
      ' und die ',
      name: 'intro_view_term_of_use_part3',
      desc: '',
      args: [],
    );
  }

  /// `Datenschutzerklärung`
  String get intro_view_term_of_use_part4 {
    return Intl.message(
      'Datenschutzerklärung',
      name: 'intro_view_term_of_use_part4',
      desc: '',
      args: [],
    );
  }

  /// ` akzeptiert.`
  String get intro_view_term_of_use_part5 {
    return Intl.message(
      ' akzeptiert.',
      name: 'intro_view_term_of_use_part5',
      desc: '',
      args: [],
    );
  }

  /// `MEHR`
  String get tiles_button_text_more {
    return Intl.message(
      'MEHR',
      name: 'tiles_button_text_more',
      desc: '',
      args: [],
    );
  }

  /// `ANZEIGEN`
  String get tiles_button_text_show {
    return Intl.message(
      'ANZEIGEN',
      name: 'tiles_button_text_show',
      desc: '',
      args: [],
    );
  }

  /// `Abfahrts­monitor`
  String get parking_view_tiles_timetable_title {
    return Intl.message(
      'Abfahrts­monitor',
      name: 'parking_view_tiles_timetable_title',
      desc: '',
      args: [],
    );
  }

  /// `Campus Rad`
  String get parking_view_tiles_campus_rad_title {
    return Intl.message(
      'Campus Rad',
      name: 'parking_view_tiles_campus_rad_title',
      desc: '',
      args: [],
    );
  }

  /// `ZEAG Carsharing`
  String get parking_view_tiles_zaeg_title {
    return Intl.message(
      'ZEAG Carsharing',
      name: 'parking_view_tiles_zaeg_title',
      desc: '',
      args: [],
    );
  }

  /// `Parken am Campus`
  String get parking_view_title_backup {
    return Intl.message(
      'Parken am Campus',
      name: 'parking_view_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `Studierende`
  String get parking_view_categories_students {
    return Intl.message(
      'Studierende',
      name: 'parking_view_categories_students',
      desc: '',
      args: [],
    );
  }

  /// `Beschäftigte`
  String get parking_view_categories_staff {
    return Intl.message(
      'Beschäftigte',
      name: 'parking_view_categories_staff',
      desc: '',
      args: [],
    );
  }

  /// `Besucher:innen`
  String get parking_view_categories_guests {
    return Intl.message(
      'Besucher:innen',
      name: 'parking_view_categories_guests',
      desc: '',
      args: [],
    );
  }

  /// `Buchsuche`
  String get booksearch_view_title_backup {
    return Intl.message(
      'Buchsuche',
      name: 'booksearch_view_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `Kontakt`
  String get contact_view_title_backup {
    return Intl.message(
      'Kontakt',
      name: 'contact_view_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `Wir können die ${model.email} nicht in anderen App öffnen.`
  String get contact_view_open_email_failed_message {
    return Intl.message(
      'Wir können die \${model.email} nicht in anderen App öffnen.',
      name: 'contact_view_open_email_failed_message',
      desc: '',
      args: [],
    );
  }

  /// `Lageplan`
  String get map_view_title_backup {
    return Intl.message(
      'Lageplan',
      name: 'map_view_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `CampusCard PaymentPortal`
  String get payment_view_title_backup {
    return Intl.message(
      'CampusCard PaymentPortal',
      name: 'payment_view_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `Nutzungsbedingungen & Datenschutzerklärung`
  String get privacy_view_headline_text {
    return Intl.message(
      'Nutzungsbedingungen & Datenschutzerklärung',
      name: 'privacy_view_headline_text',
      desc: '',
      args: [],
    );
  }

  /// `Ich akzeptiere die `
  String get privacy_view_terms_of_use_text_part1 {
    return Intl.message(
      'Ich akzeptiere die ',
      name: 'privacy_view_terms_of_use_text_part1',
      desc: '',
      args: [],
    );
  }

  /// `Nutzungsbedingungen`
  String get privacy_view_terms_of_use_text_part2 {
    return Intl.message(
      'Nutzungsbedingungen',
      name: 'privacy_view_terms_of_use_text_part2',
      desc: '',
      args: [],
    );
  }

  /// `Ich habe die `
  String get privacy_view_privacy_agreement_text_part1 {
    return Intl.message(
      'Ich habe die ',
      name: 'privacy_view_privacy_agreement_text_part1',
      desc: '',
      args: [],
    );
  }

  /// `Datenschutzerklärung`
  String get privacy_view_privacy_agreement_text_part2 {
    return Intl.message(
      'Datenschutzerklärung',
      name: 'privacy_view_privacy_agreement_text_part2',
      desc: '',
      args: [],
    );
  }

  /// ` gelesen und verstanden`
  String get privacy_view_privacy_agreement_text_part3 {
    return Intl.message(
      ' gelesen und verstanden',
      name: 'privacy_view_privacy_agreement_text_part3',
      desc: '',
      args: [],
    );
  }

  /// `Los geht's`
  String get privacy_view_accept_button_text {
    return Intl.message(
      'Los geht\'s',
      name: 'privacy_view_accept_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Abfahrtsmonitor`
  String get timetable_view_title_backup {
    return Intl.message(
      'Abfahrtsmonitor',
      name: 'timetable_view_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_view_appmenu_title {
    return Intl.message(
      'Home',
      name: 'home_view_appmenu_title',
      desc: '',
      args: [],
    );
  }

  /// `Impressum`
  String get contact_view_appmenu_title {
    return Intl.message(
      'Impressum',
      name: 'contact_view_appmenu_title',
      desc: '',
      args: [],
    );
  }

  /// `Datenschutz`
  String get privacy_view_appmenu_title {
    return Intl.message(
      'Datenschutz',
      name: 'privacy_view_appmenu_title',
      desc: '',
      args: [],
    );
  }

  /// `Nutzungsbedingungen`
  String get termsofuse_view_appmenu_title {
    return Intl.message(
      'Nutzungsbedingungen',
      name: 'termsofuse_view_appmenu_title',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get parkinglot_view_tile_expand_button_text {
    return Intl.message(
      'Details',
      name: 'parkinglot_view_tile_expand_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Für Bildungscampus Studierende mit CampusCard ist das Parken hier bis einschließlich August 2021 kostenfrei.`
  String get parkinglot_view_students_category_description_text {
    return Intl.message(
      'Für Bildungscampus Studierende mit CampusCard ist das Parken hier bis einschließlich August 2021 kostenfrei.',
      name: 'parkinglot_view_students_category_description_text',
      desc: '',
      args: [],
    );
  }

  /// `Google Maps`
  String get parkinglot_view_google_maps_text {
    return Intl.message(
      'Google Maps',
      name: 'parkinglot_view_google_maps_text',
      desc: '',
      args: [],
    );
  }

  /// `We cannot open maps app!`
  String get parkinglot_view_google_maps_error_text {
    return Intl.message(
      'We cannot open maps app!',
      name: 'parkinglot_view_google_maps_error_text',
      desc: '',
      args: [],
    );
  }

  /// `weniger`
  String get parkinglot_view_tile_collapse_button_text {
    return Intl.message(
      'weniger',
      name: 'parkinglot_view_tile_collapse_button_text',
      desc: '',
      args: [],
    );
  }

  /// `FREI`
  String get parkinglot_view_traffic_lights_free_slots_text {
    return Intl.message(
      'FREI',
      name: 'parkinglot_view_traffic_lights_free_slots_text',
      desc: '',
      args: [],
    );
  }

  /// `Campus Wetter`
  String get home_view_tiles_weather_title {
    return Intl.message(
      'Campus Wetter',
      name: 'home_view_tiles_weather_title',
      desc: '',
      args: [],
    );
  }

  /// `Uups!`
  String get error_dialog_title {
    return Intl.message(
      'Uups!',
      name: 'error_dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Leider ist beim Verbinden der App etwas schiefgelaufen. Bitte prüfe die Internetverbindung und versuche es erneut.`
  String get error_dialog_text {
    return Intl.message(
      'Leider ist beim Verbinden der App etwas schiefgelaufen. Bitte prüfe die Internetverbindung und versuche es erneut.',
      name: 'error_dialog_text',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'de', countryCode: 'DE'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
