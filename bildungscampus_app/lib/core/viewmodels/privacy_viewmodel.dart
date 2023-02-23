import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/core/services/interfaces/settings_service.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:flutter/material.dart';

class PrivacyViewModel extends ChangeNotifier {
  static const String internalPrivacyAgreementLink =
      'https://bildungscampus.hn/mein-bildungscampus-datenschutzerklaerung';
  static const String internalTermOfUseLink =
      'https://bildungscampus.hn/mein-bildungscampus-nutzungsbedingungen';

  final SettingsService _settingsService = locator<SettingsService>();
  static const String termOfUseKey = 'TermsOfUse';
  static const String privacyAgreementKey = 'Privacy';

  late bool _termsOfUse;
  late bool _privacyAgreement;

  String? _termOfUseLink;
  String? _privacyAgreementLink;

  bool get termsOfUse => _termsOfUse;
  bool get privacyAgreement => _privacyAgreement;

  bool get formValid => termsOfUse && privacyAgreement;

  String get termsOfUseLink =>
      _termOfUseLink != null && _termOfUseLink!.isNotEmpty
          ? _termOfUseLink!
          : internalTermOfUseLink;
  String get privacyAgreementLink =>
      _privacyAgreementLink != null && _privacyAgreementLink!.isNotEmpty
          ? _privacyAgreementLink!
          : internalPrivacyAgreementLink;

  Future<void> load() async {
    final settings = await _settingsService.loadSettings();
    _termsOfUse = settings.termOfUse;
    _privacyAgreement = settings.privacyAgreement;
  }

  void updateExternalLinks(List<ExternalLink>? externalLinks) {
    if (externalLinks == null) {
      return;
    }
    if (externalLinks.any((link) => link.name == termOfUseKey)) {
      _termOfUseLink =
          externalLinks.firstWhere((link) => link.name == termOfUseKey).link;
    }
    if (externalLinks.any((link) => link.name == privacyAgreementKey)) {
      _privacyAgreementLink = externalLinks
          .firstWhere((link) => link.name == privacyAgreementKey)
          .link;
    }
    notifyListeners();
  }

  Future<void> setTermsOfUse(bool? state) async {
    final newState = state ?? false;
    await _settingsService.setTermsOfUse(newState);
    _termsOfUse = newState;

    notifyListeners();
  }

  Future<void> setPrivacyAgreement(bool? state) async {
    final newState = state ?? false;
    await _settingsService.setPrivacyAgreement(newState);
    _privacyAgreement = newState;

    notifyListeners();
  }

  Future<void> acceptTerms() async {
    await _settingsService.setHideIntro(true);
  }
}
