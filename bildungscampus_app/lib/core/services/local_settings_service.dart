import 'package:bildungscampus_app/core/models/common/local_settings_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interfaces/settings_service.dart';

class LocalSettingsService implements SettingsService {
  final String _termsOfUseKey = 'Checkbox_TermsOfUseAccepted';
  final String _privacyAgreementKey = 'Checkbox_PrivacyAccepted';
  final String _hideIntroKey = 'Common_HideIntro';

  SharedPreferences? _prefs;

  Future<void> initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<LocalSettingsDto> loadSettings() async {
    await initPrefs();
    final termsOfUse = _prefs!.containsKey(_termsOfUseKey)
        ? _prefs!.getBool(_termsOfUseKey)
        : false;
    final privacyAgreement = _prefs!.containsKey(_privacyAgreementKey)
        ? _prefs?.getBool(_privacyAgreementKey)
        : false;
    final hideIntro = _prefs!.containsKey(_hideIntroKey)
        ? _prefs?.getBool(_hideIntroKey)
        : false;
    return LocalSettingsDto(
        termOfUse: termsOfUse ?? false,
        privacyAgreement: privacyAgreement ?? false,
        hideIntro: hideIntro ?? false);
  }

  @override
  Future<void> setTermsOfUse(bool state) async {
    await initPrefs();
    await _prefs?.setBool(_termsOfUseKey, state);
  }

  @override
  Future<void> setPrivacyAgreement(bool state) async {
    await initPrefs();
    await _prefs?.setBool(_privacyAgreementKey, state);
  }

  @override
  Future<void> setHideIntro(bool state) async {
    await initPrefs();
    await _prefs?.setBool(_hideIntroKey, state);
  }
}
