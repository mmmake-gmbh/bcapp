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

  /// `"Mein Bildungscampus" — der digitale Campus jederzeit griffbereit.`
  String get intro_overview_title {
    return Intl.message(
      '"Mein Bildungscampus" — der digitale Campus jederzeit griffbereit.',
      name: 'intro_overview_title',
      desc: '',
      args: [],
    );
  }

  /// `Du bist am Campus? Nutze die App über das kostenlose WLAN "Welcome@Bildungscampus".`
  String get intro_overview2_title {
    return Intl.message(
      'Du bist am Campus? Nutze die App über das kostenlose WLAN "Welcome@Bildungscampus".',
      name: 'intro_overview2_title',
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

  /// `Campus Login`
  String get intro_view_card_payment_title {
    return Intl.message(
      'Campus Login',
      name: 'intro_view_card_payment_title',
      desc: '',
      args: [],
    );
  }

  /// `Nutze die Campus internen Services mit einem Klick.`
  String get intro_view_card_payment_text {
    return Intl.message(
      'Nutze die Campus internen Services mit einem Klick.',
      name: 'intro_view_card_payment_text',
      desc: '',
      args: [],
    );
  }

  /// `Mensa`
  String get intro_view_card_mensa_title {
    return Intl.message(
      'Mensa',
      name: 'intro_view_card_mensa_title',
      desc: '',
      args: [],
    );
  }

  /// `Informiere dich über den Speiseplan zu den tagesaktuellen Gerichten.`
  String get intro_view_card_mensa_text {
    return Intl.message(
      'Informiere dich über den Speiseplan zu den tagesaktuellen Gerichten.',
      name: 'intro_view_card_mensa_text',
      desc: '',
      args: [],
    );
  }

  /// `Buchsuche`
  String get intro_view_card_booksearch_title {
    return Intl.message(
      'Buchsuche',
      name: 'intro_view_card_booksearch_title',
      desc: '',
      args: [],
    );
  }

  /// `Stöbere im Online-Katalog der Bibliothek LIV nach Medien.`
  String get intro_view_card_booksearch_text {
    return Intl.message(
      'Stöbere im Online-Katalog der Bibliothek LIV nach Medien.',
      name: 'intro_view_card_booksearch_text',
      desc: '',
      args: [],
    );
  }

  /// `Lageplan`
  String get intro_view_card_siteplan_title {
    return Intl.message(
      'Lageplan',
      name: 'intro_view_card_siteplan_title',
      desc: '',
      args: [],
    );
  }

  /// `Finde dich schnell auf dem Campus zurecht.`
  String get intro_view_card_siteplan_text {
    return Intl.message(
      'Finde dich schnell auf dem Campus zurecht.',
      name: 'intro_view_card_siteplan_text',
      desc: '',
      args: [],
    );
  }

  /// `Parken am Campus`
  String get intro_view_card_parking_title {
    return Intl.message(
      'Parken am Campus',
      name: 'intro_view_card_parking_title',
      desc: '',
      args: [],
    );
  }

  /// `Prüfe die Parkplatzauslastung in Echtzeit.`
  String get intro_view_card_parking_text {
    return Intl.message(
      'Prüfe die Parkplatzauslastung in Echtzeit.',
      name: 'intro_view_card_parking_text',
      desc: '',
      args: [],
    );
  }

  /// `Abfahrtsmonitor`
  String get intro_view_card_monitor_title {
    return Intl.message(
      'Abfahrtsmonitor',
      name: 'intro_view_card_monitor_title',
      desc: '',
      args: [],
    );
  }

  /// `Finde alle Abfahrten von Bus & Bahn rund um den Campus.`
  String get intro_view_card_monitor_text {
    return Intl.message(
      'Finde alle Abfahrten von Bus & Bahn rund um den Campus.',
      name: 'intro_view_card_monitor_text',
      desc: '',
      args: [],
    );
  }

  /// `Registrierung fehlgeschlagen. Bitte versuche es erneut!`
  String get intro_view_registration_unsuccessful {
    return Intl.message(
      'Registrierung fehlgeschlagen. Bitte versuche es erneut!',
      name: 'intro_view_registration_unsuccessful',
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

  /// `Wir können die {email} nicht in anderen App öffnen.`
  String contact_view_open_email_failed_message(String email) {
    return Intl.message(
      'Wir können die $email nicht in anderen App öffnen.',
      name: 'contact_view_open_email_failed_message',
      desc: '',
      args: [email],
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

  /// `für`
  String get privacy_view_tile_appendix {
    return Intl.message(
      'für',
      name: 'privacy_view_tile_appendix',
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

  /// `Wir können die Maps-App nicht öffnen!`
  String get parkinglot_view_google_maps_error_text {
    return Intl.message(
      'Wir können die Maps-App nicht öffnen!',
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

  /// `Bildungscampus Wetter`
  String get home_view_tiles_weather_title {
    return Intl.message(
      'Bildungscampus Wetter',
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

  /// `für Studierende`
  String get tiles_parking_for_students_text {
    return Intl.message(
      'für Studierende',
      name: 'tiles_parking_for_students_text',
      desc: '',
      args: [],
    );
  }

  /// `Hallo,`
  String get welcome_tile_hello {
    return Intl.message(
      'Hallo,',
      name: 'welcome_tile_hello',
      desc: '',
      args: [],
    );
  }

  /// `Abmelden fehlgeschlagen. Bitte versuche es erneut!`
  String get setting_view_logout_unsuccessful {
    return Intl.message(
      'Abmelden fehlgeschlagen. Bitte versuche es erneut!',
      name: 'setting_view_logout_unsuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Benutzerkonto verwalten`
  String get setting_view_account_setting {
    return Intl.message(
      'Benutzerkonto verwalten',
      name: 'setting_view_account_setting',
      desc: '',
      args: [],
    );
  }

  /// `Anmeldungen verwalten`
  String get setting_view_sessions_setting {
    return Intl.message(
      'Anmeldungen verwalten',
      name: 'setting_view_sessions_setting',
      desc: '',
      args: [],
    );
  }

  /// `CampusCard verwalten`
  String get setting_view_campus_card_setting {
    return Intl.message(
      'CampusCard verwalten',
      name: 'setting_view_campus_card_setting',
      desc: '',
      args: [],
    );
  }

  /// `Abmelden`
  String get setting_view_logout_setting {
    return Intl.message(
      'Abmelden',
      name: 'setting_view_logout_setting',
      desc: '',
      args: [],
    );
  }

  /// `Kontoeinstellungen`
  String get setting_view_title {
    return Intl.message(
      'Kontoeinstellungen',
      name: 'setting_view_title',
      desc: '',
      args: [],
    );
  }

  /// `Campus Login`
  String get login_tile_title {
    return Intl.message(
      'Campus Login',
      name: 'login_tile_title',
      desc: '',
      args: [],
    );
  }

  /// `Jetzt einloggen und auf die Inhalte zugreifen`
  String get login_tile_text {
    return Intl.message(
      'Jetzt einloggen und auf die Inhalte zugreifen',
      name: 'login_tile_text',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_tile_button_text {
    return Intl.message(
      'Login',
      name: 'login_tile_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Profil`
  String get home_view_setting_button_tooltip {
    return Intl.message(
      'Profil',
      name: 'home_view_setting_button_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_view_title {
    return Intl.message(
      'Login',
      name: 'login_view_title',
      desc: '',
      args: [],
    );
  }

  /// `Wir können die {url} nicht in anderen App öffnen.`
  String fourtytwo_view_snackbar_text(String url) {
    return Intl.message(
      'Wir können die $url nicht in anderen App öffnen.',
      name: 'fourtytwo_view_snackbar_text',
      desc: '',
      args: [url],
    );
  }

  /// `Bist du ein Student mit einer Leidenschaft für das Programmieren und die Zusammenarbeit? \n\nDie Teilnahme am BildungsCampus App Open-Source-Projekt auf GitHub, das darauf abzielt, die Campus-Erfahrungen von Studenten zu verbessern, ist eine großartige Gelegenheit, deine Fähigkeiten zu schärfen, von erfahrenen Entwicklern zu lernen und zu einem bedeutsamen Projekt beizutragen, das von Menschen an dem Campus genutzt wird. \n\nMach mit, gestalte Veränderungen und sei Teil von etwas Besonderem!`
  String get fourtytwo_view_text {
    return Intl.message(
      'Bist du ein Student mit einer Leidenschaft für das Programmieren und die Zusammenarbeit? \n\nDie Teilnahme am BildungsCampus App Open-Source-Projekt auf GitHub, das darauf abzielt, die Campus-Erfahrungen von Studenten zu verbessern, ist eine großartige Gelegenheit, deine Fähigkeiten zu schärfen, von erfahrenen Entwicklern zu lernen und zu einem bedeutsamen Projekt beizutragen, das von Menschen an dem Campus genutzt wird. \n\nMach mit, gestalte Veränderungen und sei Teil von etwas Besonderem!',
      name: 'fourtytwo_view_text',
      desc: '',
      args: [],
    );
  }

  /// `One more thing...`
  String get fourtytwo_view_button_text {
    return Intl.message(
      'One more thing...',
      name: 'fourtytwo_view_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Kienzler Fahrradbox`
  String get keinzler_bike_view_title_backup {
    return Intl.message(
      'Kienzler Fahrradbox',
      name: 'keinzler_bike_view_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `Weiter`
  String get new_flag_widget_close_button {
    return Intl.message(
      'Weiter',
      name: 'new_flag_widget_close_button',
      desc: '',
      args: [],
    );
  }

  /// `That´s new:`
  String get new_flag_widget_title {
    return Intl.message(
      'That´s new:',
      name: 'new_flag_widget_title',
      desc: '',
      args: [],
    );
  }

  /// `{amount} FREI`
  String parking_view_parkinglistitem_occupancy_text(String amount) {
    return Intl.message(
      '$amount FREI',
      name: 'parking_view_parkinglistitem_occupancy_text',
      desc: '',
      args: [amount],
    );
  }

  /// `Dessert`
  String get mensa_view_meal_categories_dessert {
    return Intl.message(
      'Dessert',
      name: 'mensa_view_meal_categories_dessert',
      desc: '',
      args: [],
    );
  }

  /// `Dessert vegan`
  String get mensa_view_meal_categories_dessert_vegan {
    return Intl.message(
      'Dessert vegan',
      name: 'mensa_view_meal_categories_dessert_vegan',
      desc: '',
      args: [],
    );
  }

  /// `Vegan`
  String get mensa_view_meal_categories_vegan {
    return Intl.message(
      'Vegan',
      name: 'mensa_view_meal_categories_vegan',
      desc: '',
      args: [],
    );
  }

  /// `Vegetarisch`
  String get mensa_view_meal_categories_vegetarian {
    return Intl.message(
      'Vegetarisch',
      name: 'mensa_view_meal_categories_vegetarian',
      desc: '',
      args: [],
    );
  }

  /// `Tierisch`
  String get mensa_view_meal_categories_meat {
    return Intl.message(
      'Tierisch',
      name: 'mensa_view_meal_categories_meat',
      desc: '',
      args: [],
    );
  }

  /// `Suppentopf`
  String get mensa_view_meal_categories_soup {
    return Intl.message(
      'Suppentopf',
      name: 'mensa_view_meal_categories_soup',
      desc: '',
      args: [],
    );
  }

  /// `Mensa`
  String get mensa_view_title_backup {
    return Intl.message(
      'Mensa',
      name: 'mensa_view_title_backup',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get mensa_view_info_dialog_title {
    return Intl.message(
      'Info',
      name: 'mensa_view_info_dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get mensa_view_info_dialog_details {
    return Intl.message(
      'Details',
      name: 'mensa_view_info_dialog_details',
      desc: '',
      args: [],
    );
  }

  /// `Öffnungzeiten`
  String get mensa_view_info_content_opening_hours {
    return Intl.message(
      'Öffnungzeiten',
      name: 'mensa_view_info_content_opening_hours',
      desc: '',
      args: [],
    );
  }

  /// `Mo-Fr 11-14.30 Uhr\nZum Lernen 14.30-18 Uhr`
  String get mensa_view_info_content_opening_hours_value {
    return Intl.message(
      'Mo-Fr 11-14.30 Uhr\nZum Lernen 14.30-18 Uhr',
      name: 'mensa_view_info_content_opening_hours_value',
      desc: '',
      args: [],
    );
  }

  /// `Vegan, Vegetarisch`
  String get mensa_view_info_content_vegan_label {
    return Intl.message(
      'Vegan, Vegetarisch',
      name: 'mensa_view_info_content_vegan_label',
      desc: '',
      args: [],
    );
  }

  /// `JA`
  String get mensa_view_info_content_vegan_value {
    return Intl.message(
      'JA',
      name: 'mensa_view_info_content_vegan_value',
      desc: '',
      args: [],
    );
  }

  /// `CampusCard Aufladestation`
  String get mensa_view_info_content_campuscard_label {
    return Intl.message(
      'CampusCard Aufladestation',
      name: 'mensa_view_info_content_campuscard_label',
      desc: '',
      args: [],
    );
  }

  /// `JA`
  String get mensa_view_info_content_campuscard_value {
    return Intl.message(
      'JA',
      name: 'mensa_view_info_content_campuscard_value',
      desc: '',
      args: [],
    );
  }

  /// `Bezahlmöglichkeiten`
  String get mensa_view_info_content_payment_label {
    return Intl.message(
      'Bezahlmöglichkeiten',
      name: 'mensa_view_info_content_payment_label',
      desc: '',
      args: [],
    );
  }

  /// `Gästekarte Verzehr`
  String get mensa_view_info_content_payment_value {
    return Intl.message(
      'Gästekarte Verzehr',
      name: 'mensa_view_info_content_payment_value',
      desc: '',
      args: [],
    );
  }

  /// `Heute geschlossen `
  String get mensa_view_closed_text {
    return Intl.message(
      'Heute geschlossen ',
      name: 'mensa_view_closed_text',
      desc: '',
      args: [],
    );
  }

  /// `Speiseplan noch nicht verfügbar`
  String get mensa_view_not_available {
    return Intl.message(
      'Speiseplan noch nicht verfügbar',
      name: 'mensa_view_not_available',
      desc: '',
      args: [],
    );
  }

  /// `Speiseplan`
  String get mensa_view_timeline_menu_label {
    return Intl.message(
      'Speiseplan',
      name: 'mensa_view_timeline_menu_label',
      desc: '',
      args: [],
    );
  }

  /// `Herzlich Willkommen\n\nbei "Mein Bildungscampus" — deinem mobilen Helfer rund um den Campus!`
  String get intro_welcome_view_main_text {
    return Intl.message(
      'Herzlich Willkommen\n\nbei "Mein Bildungscampus" — deinem mobilen Helfer rund um den Campus!',
      name: 'intro_welcome_view_main_text',
      desc: '',
      args: [],
    );
  }

  /// `Login via CampusCard`
  String get intro_welcome_view_login_button {
    return Intl.message(
      'Login via CampusCard',
      name: 'intro_welcome_view_login_button',
      desc: '',
      args: [],
    );
  }

  /// `Weiter ohne Login`
  String get intro_welcome_view_skip_login_button {
    return Intl.message(
      'Weiter ohne Login',
      name: 'intro_welcome_view_skip_login_button',
      desc: '',
      args: [],
    );
  }

  /// `Noch keine CampusCard?\n`
  String get intro_welcome_view_registration_text_part1 {
    return Intl.message(
      'Noch keine CampusCard?\n',
      name: 'intro_welcome_view_registration_text_part1',
      desc: '',
      args: [],
    );
  }

  /// `Hier registrieren`
  String get intro_welcome_view_registration_text_part2 {
    return Intl.message(
      'Hier registrieren',
      name: 'intro_welcome_view_registration_text_part2',
      desc: '',
      args: [],
    );
  }

  /// `Willkommen am Campus!`
  String get welcome_tile_no_user_text {
    return Intl.message(
      'Willkommen am Campus!',
      name: 'welcome_tile_no_user_text',
      desc: '',
      args: [],
    );
  }

  /// `Biometrische Authentifizierung aktiviert`
  String get setting_view_biometric_setting_text {
    return Intl.message(
      'Biometrische Authentifizierung aktiviert',
      name: 'setting_view_biometric_setting_text',
      desc: '',
      args: [],
    );
  }

  /// `Stoßzeiten`
  String get mensa_view_forecast_title {
    return Intl.message(
      'Stoßzeiten',
      name: 'mensa_view_forecast_title',
      desc: '',
      args: [],
    );
  }

  /// `Mensa am Bildungscampus`
  String get mensa_view_info_content_title {
    return Intl.message(
      'Mensa am Bildungscampus',
      name: 'mensa_view_info_content_title',
      desc: '',
      args: [],
    );
  }

  /// `\n(im PaymentPortal zu buchen)`
  String get parkinglot_view_pay_portal_text {
    return Intl.message(
      '\n(im PaymentPortal zu buchen)',
      name: 'parkinglot_view_pay_portal_text',
      desc: '',
      args: [],
    );
  }

  /// `Möchtest du zukünftig biometrischer Authentifizierung zur Anmeldung verwenden ?`
  String get login_view_prompt_biometric_text {
    return Intl.message(
      'Möchtest du zukünftig biometrischer Authentifizierung zur Anmeldung verwenden ?',
      name: 'login_view_prompt_biometric_text',
      desc: '',
      args: [],
    );
  }

  /// `JA`
  String get login_view_prompt_biometric_accept_button {
    return Intl.message(
      'JA',
      name: 'login_view_prompt_biometric_accept_button',
      desc: '',
      args: [],
    );
  }

  /// `SPÄTER`
  String get login_view_prompt_biometric_dismiss_button {
    return Intl.message(
      'SPÄTER',
      name: 'login_view_prompt_biometric_dismiss_button',
      desc: '',
      args: [],
    );
  }

  /// `Biometrische Authentifizierung`
  String get login_view_biometric_authenticate_reason {
    return Intl.message(
      'Biometrische Authentifizierung',
      name: 'login_view_biometric_authenticate_reason',
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
