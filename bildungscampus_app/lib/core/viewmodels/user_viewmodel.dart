import 'package:bildungscampus_app/core/enums/user_type.dart';
import 'package:bildungscampus_app/core/viewmodels/base_viewmodel.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserViewModel extends BaseViewModel {
  final CidaasLoginProvider _cidaasProvider = locator<CidaasLoginProvider>();
  late FlutterSecureStorage _secureStorage;

  final String storedLanguageKey = 'storedLanguage';

  bool _isLogged = false;
  String? _userName;
  String? _profileInfo;
  String? _ssoCookie;
  Locale? _locale;

  bool get isLogged => _isLogged;
  String? get userName => _userName;
  UserType get userType => _mapUserType(_profileInfo);
  String? get ssoCookie => _ssoCookie;

  Locale? get locale => _locale;

  UserViewModel(FlutterSecureStorage storage) {
    _secureStorage = storage;
    initLoggedInData();
  }

  Future<void> initLoggedInData() async {
    final storedToken = await _cidaasProvider.getStoredAccessToken();
    _userName = _getUserName(storedToken);
    _ssoCookie = _getSsoCookie(storedToken);
    _profileInfo = _getProfileInfo(storedToken);
    _isLogged = _userName != null && _ssoCookie != null;

    _locale = await _getLocale();

    notifyListeners();
  }

  Future<bool> logout(BuildContext context) async {
    final logout = await _cidaasProvider.doLogout(context);

    if (logout) {
      _isLogged = false;
      _userName = null;
      _ssoCookie = null;
      _profileInfo = null;
      notifyListeners();
    }

    return logout;
  }

  String? _getSsoCookie(TokenEntity? storedToken) {
    if (storedToken?.ssoCookie == null || storedToken!.ssoCookie!.isEmpty) {
      return null;
    }

    return storedToken.ssoCookie;
  }

  String? _getUserName(TokenEntity? storedToken) {
    final tokenInfo = _mapIdToken(storedToken);

    if (tokenInfo == null) {
      return null;
    }

    return tokenInfo['name'];
  }

  String? _getProfileInfo(TokenEntity? storedToken) {
    final tokenInfo = _mapIdToken(storedToken);

    if (tokenInfo == null) {
      return null;
    }

    return tokenInfo['customFields']['profil'];
  }

  Map<String, dynamic>? _mapIdToken(TokenEntity? storedToken) {
    if (storedToken?.idToken == null || storedToken!.idToken!.isEmpty) {
      return null;
    }

    if (storedToken.idToken!.split('.').length != 3) {
      return null;
    }

    return JwtDecoder.decode(storedToken.idToken!);
  }

  UserType _mapUserType(String? userProfile) {
    return switch (userProfile) {
      '14-A' => UserType.fourtyTwo,
      '08-C' => UserType.admin,
      _ => UserType.notLoggedIn
    };
  }

  Future<Locale?> _getLocale() async {
    final lang = await _secureStorage.read(key: storedLanguageKey);
    if (lang != null) {
      if (!lang.contains('-')) {
        return Locale(lang);
      }

      final split = lang.split('-');
      return Locale(split[0], split[1]);
    }

    return null;
  }

  Future<void> saveLanguage(Locale locale) async {
    final lang = locale.countryCode != null
        ? '${locale.languageCode}-${locale.countryCode}'
        : locale.languageCode;
    await _secureStorage.write(key: storedLanguageKey, value: lang);
    _locale = locale;
    notifyListeners();
  }
}
