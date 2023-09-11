import 'dart:developer';

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
  String? _ssoCookie;
  Locale? _locale;

  bool get isLogged => _isLogged;
  String? get userName => _userName;
  String? get ssoCookie => _ssoCookie;

  Locale? get locale => _locale;

  UserViewModel(FlutterSecureStorage storage) {
    _secureStorage = storage;
    loggedIn();
  }

  Future<void> loggedIn() async {
    final storedToken = await _cidaasProvider.getStoredAccessToken();
    _userName = _getUserName(storedToken);
    _ssoCookie = _getSsoCookie(storedToken);
    _isLogged = _userName != null && _ssoCookie != null;

    final lang = await _secureStorage.read(key: storedLanguageKey);
    if (lang != null) {
      final split = lang.split('-');
      _locale = Locale(split[0], split[1]);
    }

    log('loggedin');

    notifyListeners();
  }

  Future<bool> logout(BuildContext context) async {
    final logout = await _cidaasProvider.doLogout(context);

    if (logout) {
      _isLogged = false;
      _userName = null;
      _ssoCookie = null;
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
    if (storedToken?.idToken == null || storedToken!.idToken!.isEmpty) {
      return null;
    }

    if (storedToken.idToken!.split('.').length != 3) {
      return null;
    }

    final tokenInfo = JwtDecoder.decode(storedToken.idToken!);

    return tokenInfo['name'];
  }

  Future<void> saveLanguage(Locale locale) async {
    final lang = '${locale.languageCode}-${locale.countryCode}';
    await _secureStorage.write(key: storedLanguageKey, value: lang);
    _locale = locale;
    notifyListeners();
  }

  Locale? getCurrentLocale() {
    return locale;
  }
}
