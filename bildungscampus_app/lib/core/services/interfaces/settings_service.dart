import 'package:bildungscampus_app/core/models/common/local_settings_dto.dart';

abstract class SettingsService {
  Future<LocalSettingsDto> loadSettings();
  Future<void> setTermsOfUse(bool state);
  Future<void> setPrivacyAgreement(bool state);
  Future<void> setHideIntro(bool state);
}
