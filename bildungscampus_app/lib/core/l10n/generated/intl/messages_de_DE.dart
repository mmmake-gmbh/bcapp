// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de_DE locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de_DE';

  static String m0(email) =>
      "Wir können die ${email} nicht in anderen App öffnen.";

  static String m1(url) => "Wir können die ${url} nicht in anderen App öffnen.";

  static String m2(amount) => "${amount} FREI";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "booksearch_view_title_backup":
            MessageLookupByLibrary.simpleMessage("Buchsuche"),
        "contact_view_appmenu_title":
            MessageLookupByLibrary.simpleMessage("Impressum"),
        "contact_view_open_email_failed_message": m0,
        "contact_view_show_licenses_button_text":
            MessageLookupByLibrary.simpleMessage("Alle Lizenzen anzeigen"),
        "contact_view_title_backup":
            MessageLookupByLibrary.simpleMessage("Kontakt"),
        "error_dialog_text": MessageLookupByLibrary.simpleMessage(
            "Leider ist beim Verbinden der App etwas schiefgelaufen. Bitte prüfe die Internetverbindung und versuche es erneut."),
        "error_dialog_title": MessageLookupByLibrary.simpleMessage("Uups!"),
        "fourtytwo_view_button_text":
            MessageLookupByLibrary.simpleMessage("One more thing..."),
        "fourtytwo_view_snackbar_text": m1,
        "fourtytwo_view_text": MessageLookupByLibrary.simpleMessage(
            "Bist du ein Student mit einer Leidenschaft für das Programmieren und die Zusammenarbeit? \n\nDie Teilnahme am BildungsCampus App Open-Source-Projekt auf GitHub, das darauf abzielt, die Campus-Erfahrungen von Studenten zu verbessern, ist eine großartige Gelegenheit, deine Fähigkeiten zu schärfen, von erfahrenen Entwicklern zu lernen und zu einem bedeutsamen Projekt beizutragen, das von Menschen an dem Campus genutzt wird. \n\nMach mit, gestalte Veränderungen und sei Teil von etwas Besonderem!"),
        "home_view_appmenu_title": MessageLookupByLibrary.simpleMessage("Home"),
        "home_view_setting_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Profil"),
        "home_view_tiles_weather_title":
            MessageLookupByLibrary.simpleMessage("Bildungscampus Wetter"),
        "intro_overview2_title": MessageLookupByLibrary.simpleMessage(
            "Du bist am Campus? Nutze die App über das kostenlose WLAN \"Welcome@Bildungscampus\"."),
        "intro_overview_title": MessageLookupByLibrary.simpleMessage(
            "\"Mein Bildungscampus\" — der digitale Campus jederzeit griffbereit."),
        "intro_view_card_booksearch_text": MessageLookupByLibrary.simpleMessage(
            "Stöbere im Online-Katalog der Bibliothek LIV nach Medien."),
        "intro_view_card_booksearch_title":
            MessageLookupByLibrary.simpleMessage("Buchsuche"),
        "intro_view_card_mensa_text": MessageLookupByLibrary.simpleMessage(
            "Informiere dich über den Speiseplan zu den tagesaktuellen Gerichten."),
        "intro_view_card_mensa_title":
            MessageLookupByLibrary.simpleMessage("Mensa"),
        "intro_view_card_monitor_text": MessageLookupByLibrary.simpleMessage(
            "Finde alle Abfahrten von Bus & Bahn rund um den Campus."),
        "intro_view_card_monitor_title":
            MessageLookupByLibrary.simpleMessage("Abfahrtsmonitor"),
        "intro_view_card_parking_text": MessageLookupByLibrary.simpleMessage(
            "Prüfe die Parkplatzauslastung in Echtzeit."),
        "intro_view_card_parking_title":
            MessageLookupByLibrary.simpleMessage("Parken am Campus"),
        "intro_view_card_payment_text": MessageLookupByLibrary.simpleMessage(
            "Nutze die Campus internen Services mit einem Klick."),
        "intro_view_card_payment_title":
            MessageLookupByLibrary.simpleMessage("Campus Login"),
        "intro_view_card_siteplan_text": MessageLookupByLibrary.simpleMessage(
            "Finde dich schnell auf dem Campus zurecht."),
        "intro_view_card_siteplan_title":
            MessageLookupByLibrary.simpleMessage("Lageplan"),
        "intro_view_registration_unsuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Registrierung fehlgeschlagen. Bitte versuche es erneut!"),
        "intro_view_skip_intro":
            MessageLookupByLibrary.simpleMessage("Intro überspringen"),
        "intro_view_stop_intro":
            MessageLookupByLibrary.simpleMessage("Intro beenden"),
        "intro_view_term_of_use_part1": MessageLookupByLibrary.simpleMessage(
            "Mit der Nutzung der App werden die "),
        "intro_view_term_of_use_part2":
            MessageLookupByLibrary.simpleMessage("Nutzungsbedingungen"),
        "intro_view_term_of_use_part3":
            MessageLookupByLibrary.simpleMessage(" und die "),
        "intro_view_term_of_use_part4":
            MessageLookupByLibrary.simpleMessage("Datenschutzerklärung"),
        "intro_view_term_of_use_part5":
            MessageLookupByLibrary.simpleMessage(" akzeptiert."),
        "intro_welcome_view_login_button":
            MessageLookupByLibrary.simpleMessage("Login via CampusCard"),
        "intro_welcome_view_main_text": MessageLookupByLibrary.simpleMessage(
            "Herzlich Willkommen\n\nbei \"Mein Bildungscampus\" — deinem mobilen Helfer rund um den Campus!"),
        "intro_welcome_view_registration_text_part1":
            MessageLookupByLibrary.simpleMessage("Noch keine CampusCard?\n"),
        "intro_welcome_view_registration_text_part2":
            MessageLookupByLibrary.simpleMessage("Hier registrieren"),
        "intro_welcome_view_skip_login_button":
            MessageLookupByLibrary.simpleMessage("Weiter ohne Login"),
        "keinzler_bike_view_title_backup":
            MessageLookupByLibrary.simpleMessage("Kienzler Fahrradbox"),
        "login_tile_button_text": MessageLookupByLibrary.simpleMessage("Login"),
        "login_tile_text": MessageLookupByLibrary.simpleMessage(
            "Jetzt einloggen und auf die Inhalte zugreifen"),
        "login_tile_title":
            MessageLookupByLibrary.simpleMessage("Campus Login"),
        "login_view_biometric_authenticate_reason":
            MessageLookupByLibrary.simpleMessage(
                "Biometrische Authentifizierung"),
        "login_view_prompt_biometric_accept_button":
            MessageLookupByLibrary.simpleMessage("JA"),
        "login_view_prompt_biometric_dismiss_button":
            MessageLookupByLibrary.simpleMessage("SPÄTER"),
        "login_view_prompt_biometric_text": MessageLookupByLibrary.simpleMessage(
            "Möchtest du zukünftig biometrischer Authentifizierung zur Anmeldung verwenden?"),
        "login_view_title": MessageLookupByLibrary.simpleMessage("Login"),
        "map_view_title_backup":
            MessageLookupByLibrary.simpleMessage("Lageplan"),
        "mensa_view_closed_text":
            MessageLookupByLibrary.simpleMessage("Heute geschlossen "),
        "mensa_view_forecast_title":
            MessageLookupByLibrary.simpleMessage("Stoßzeiten"),
        "mensa_view_info_content_campuscard_label":
            MessageLookupByLibrary.simpleMessage("CampusCard Aufladestation"),
        "mensa_view_info_content_campuscard_value":
            MessageLookupByLibrary.simpleMessage("JA"),
        "mensa_view_info_content_opening_hours":
            MessageLookupByLibrary.simpleMessage("Öffnungzeiten"),
        "mensa_view_info_content_opening_hours_value":
            MessageLookupByLibrary.simpleMessage(
                "Mo-Fr 11-14.30 Uhr\nZum Lernen 14.30-18 Uhr"),
        "mensa_view_info_content_payment_label":
            MessageLookupByLibrary.simpleMessage("Bezahlmöglichkeiten"),
        "mensa_view_info_content_payment_value":
            MessageLookupByLibrary.simpleMessage("Gästekarte Verzehr"),
        "mensa_view_info_content_title":
            MessageLookupByLibrary.simpleMessage("Mensa am Bildungscampus"),
        "mensa_view_info_content_vegan_label":
            MessageLookupByLibrary.simpleMessage("Vegan, Vegetarisch"),
        "mensa_view_info_content_vegan_value":
            MessageLookupByLibrary.simpleMessage("JA"),
        "mensa_view_info_dialog_details":
            MessageLookupByLibrary.simpleMessage("Details"),
        "mensa_view_info_dialog_title":
            MessageLookupByLibrary.simpleMessage("Info"),
        "mensa_view_meal_categories_dessert":
            MessageLookupByLibrary.simpleMessage("Dessert"),
        "mensa_view_meal_categories_dessert_vegan":
            MessageLookupByLibrary.simpleMessage("Dessert vegan"),
        "mensa_view_meal_categories_meat":
            MessageLookupByLibrary.simpleMessage("Tierisch"),
        "mensa_view_meal_categories_soup":
            MessageLookupByLibrary.simpleMessage("Suppentopf"),
        "mensa_view_meal_categories_vegan":
            MessageLookupByLibrary.simpleMessage("Vegan"),
        "mensa_view_meal_categories_vegetarian":
            MessageLookupByLibrary.simpleMessage("Vegetarisch"),
        "mensa_view_not_available": MessageLookupByLibrary.simpleMessage(
            "Speiseplan noch nicht verfügbar"),
        "mensa_view_timeline_menu_label":
            MessageLookupByLibrary.simpleMessage("Speiseplan"),
        "mensa_view_title_backup":
            MessageLookupByLibrary.simpleMessage("Mensa"),
        "new_flag_widget_close_button":
            MessageLookupByLibrary.simpleMessage("Weiter"),
        "new_flag_widget_title":
            MessageLookupByLibrary.simpleMessage("That´s new:"),
        "parking_view_categories_guests":
            MessageLookupByLibrary.simpleMessage("Besucher:innen"),
        "parking_view_categories_staff":
            MessageLookupByLibrary.simpleMessage("Beschäftigte"),
        "parking_view_categories_students":
            MessageLookupByLibrary.simpleMessage("Studierende"),
        "parking_view_parkinglistitem_occupancy_text": m2,
        "parking_view_tiles_campus_rad_title":
            MessageLookupByLibrary.simpleMessage("Campus Rad"),
        "parking_view_tiles_timetable_title":
            MessageLookupByLibrary.simpleMessage("Abfahrts­monitor"),
        "parking_view_tiles_zaeg_title":
            MessageLookupByLibrary.simpleMessage("ZEAG Carsharing"),
        "parking_view_title_backup":
            MessageLookupByLibrary.simpleMessage("Parken am Campus"),
        "parkinglot_view_google_maps_error_text":
            MessageLookupByLibrary.simpleMessage(
                "Wir können die Maps-App nicht öffnen!"),
        "parkinglot_view_google_maps_text":
            MessageLookupByLibrary.simpleMessage("Google Maps"),
        "parkinglot_view_pay_portal_text": MessageLookupByLibrary.simpleMessage(
            "\n(im PaymentPortal zu buchen)"),
        "parkinglot_view_students_category_description_text":
            MessageLookupByLibrary.simpleMessage(
                "Für Bildungscampus Studierende mit CampusCard ist das Parken hier bis einschließlich August 2021 kostenfrei."),
        "parkinglot_view_tile_collapse_button_text":
            MessageLookupByLibrary.simpleMessage("weniger"),
        "parkinglot_view_tile_expand_button_text":
            MessageLookupByLibrary.simpleMessage("Details"),
        "parkinglot_view_traffic_lights_free_slots_text":
            MessageLookupByLibrary.simpleMessage("FREI"),
        "payment_view_title_backup":
            MessageLookupByLibrary.simpleMessage("CampusCard PaymentPortal"),
        "privacy_view_accept_button_text":
            MessageLookupByLibrary.simpleMessage("Los geht\'s"),
        "privacy_view_appmenu_title":
            MessageLookupByLibrary.simpleMessage("Datenschutz"),
        "privacy_view_headline_text": MessageLookupByLibrary.simpleMessage(
            "Nutzungsbedingungen & Datenschutzerklärung"),
        "privacy_view_privacy_agreement_text_part1":
            MessageLookupByLibrary.simpleMessage(
                "Datenschutzhinweise finden Sie "),
        "privacy_view_privacy_agreement_text_part2":
            MessageLookupByLibrary.simpleMessage("hier"),
        "privacy_view_terms_of_use_text_part1":
            MessageLookupByLibrary.simpleMessage("Ich akzeptiere die "),
        "privacy_view_terms_of_use_text_part2":
            MessageLookupByLibrary.simpleMessage("Nutzungsbedingungen"),
        "privacy_view_tile_appendix":
            MessageLookupByLibrary.simpleMessage("für"),
        "setting_view_account_setting":
            MessageLookupByLibrary.simpleMessage("Benutzerkonto verwalten"),
        "setting_view_biometric_setting_text":
            MessageLookupByLibrary.simpleMessage(
                "Biometrische Authentifizierung aktiviert"),
        "setting_view_campus_card_setting":
            MessageLookupByLibrary.simpleMessage("CampusCard verwalten"),
        "setting_view_logout_setting":
            MessageLookupByLibrary.simpleMessage("Abmelden"),
        "setting_view_logout_unsuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Abmelden fehlgeschlagen. Bitte versuche es erneut!"),
        "setting_view_sessions_setting":
            MessageLookupByLibrary.simpleMessage("Anmeldungen verwalten"),
        "setting_view_title":
            MessageLookupByLibrary.simpleMessage("Kontoeinstellungen"),
        "termsofuse_view_appmenu_title":
            MessageLookupByLibrary.simpleMessage("Nutzungsbedingungen"),
        "tiles_button_text_more": MessageLookupByLibrary.simpleMessage("MEHR"),
        "tiles_button_text_show":
            MessageLookupByLibrary.simpleMessage("ANZEIGEN"),
        "tiles_parking_for_students_text":
            MessageLookupByLibrary.simpleMessage("für Studierende"),
        "timetable_view_title_backup":
            MessageLookupByLibrary.simpleMessage("Abfahrtsmonitor"),
        "welcome_tile_hello": MessageLookupByLibrary.simpleMessage("Hallo,"),
        "welcome_tile_no_user_text":
            MessageLookupByLibrary.simpleMessage("Willkommen am Campus!")
      };
}
