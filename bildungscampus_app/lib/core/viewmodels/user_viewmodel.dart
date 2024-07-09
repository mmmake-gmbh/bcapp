import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

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
  final String biometricActivatedKey = 'biometricActivated';
  final String biometricInitializedKey = 'biometricInitialized';

  bool _isLogged = false;
  String? _userName;
  String? _profileInfo;
  String? _ssoCookie;
  Locale? _locale;
  bool _useBiometricLogin = false;
  bool _isBiometricInitialized = false;

  bool get isLogged => _isLogged;
  String? get userName => _userName;
  UserType get userType => _mapUserType(_profileInfo);
  String? get ssoCookie => _ssoCookie;

  Locale? get locale => _locale;

  bool get useBiometricLoginActivated => _useBiometricLogin;
  bool get isBiometricInitialized => _isBiometricInitialized;

  UserViewModel(FlutterSecureStorage storage) {
    _secureStorage = storage;
    initLoggedInData();
  }

  Future<void> initLoggedInData() async {
    final storedToken = await _cidaasProvider.getStoredAccessToken();
    _userName = _getUserName(storedToken);
    _ssoCookie = _getSsoCookie(storedToken);
    _profileInfo = _getProfileInfo(storedToken);
    _isLogged = storedToken?.idToken != null && _ssoCookie != null;

    _locale = await _getLocale();
    _useBiometricLogin = await _isBiometricLoginActivated();
    _isBiometricInitialized = await _isBiometricLoginInitialized();

    notifyListeners();
  }

  Future<bool> logout(BuildContext context) async {
    final logout = await _cidaasProvider.doLogout(context);

    if (logout) {
      _isLogged = false;
      _userName = null;
      _ssoCookie = null;
      _profileInfo = null;
      await resetBiometricInitialization();

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

  bool isSsoCookieValid() {
    if (_ssoCookie == null || _ssoCookie!.isEmpty) {
      return false;
    }

    final cookie = Cookie.fromSetCookieValue(_ssoCookie!);
    return cookie.expires == null || cookie.expires!.isAfter(DateTime.now());
  }

  String? _getUserName(TokenEntity? storedToken) {
    final tokenInfo = _mapIdToken(storedToken);

    log(tokenInfo.toString());

    if (tokenInfo == null) {
      return null;
    }

    return "${tokenInfo['given_name']} ${tokenInfo['family_name']}";
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

  Future<bool> _isBiometricLoginActivated() async {
    final isActivatedString =
        await _secureStorage.read(key: biometricActivatedKey);
    return bool.tryParse(isActivatedString ?? "") ?? false;
  }

  Future<bool> _isBiometricLoginInitialized() async {
    final isActivatedString =
        await _secureStorage.read(key: biometricInitializedKey);
    return bool.tryParse(isActivatedString ?? "") ?? false;
  }

  Future<void> updateBiometricLogin(bool newValue) async {
    await _biometricInitialized();
    await _secureStorage.write(
        key: biometricActivatedKey, value: newValue.toString());
    _useBiometricLogin = newValue;
    notifyListeners();
  }

  Future<void> resetBiometricInitialization() async {
    await _secureStorage.delete(key: biometricInitializedKey);
    _isBiometricInitialized = false;
    notifyListeners();
  }

  Future<void> _biometricInitialized() async {
    await _secureStorage.write(
        key: biometricInitializedKey, value: true.toString());
    _isBiometricInitialized = true;
  }

  Future<void> saveLanguage(Locale locale) async {
    final lang = locale.countryCode != null
        ? '${locale.languageCode}-${locale.countryCode}'
        : locale.languageCode;
    await _secureStorage.write(key: storedLanguageKey, value: lang);
    _locale = locale;
    notifyListeners();
  }

  Future<void> refreshAccessTokenAndCookie() async {
    final storedToken = await _cidaasProvider.getStoredAccessToken();
    if (storedToken?.accessToken != null &&
        storedToken?.refreshToken != null &&
        !_isRefreshTokenExpired(storedToken!.refreshToken!) &&
        _cidaasProvider.isAccessTokenExpired(storedToken.accessToken!)) {
      log("cidaas -> refreshToken");
      await _cidaasProvider
          .renewAccessTokenByRefreshToken(storedToken.refreshToken!);
    }
    await renewSsoCookie();
  }

  Future<void> renewSsoCookie() async {
    try {
      final storedToken = await _cidaasProvider.getStoredAccessToken();
      final queryStrings = <String, String>{
        'response_type': 'code',
        'client_id': _cidaasProvider.cidaasConf.clientId,
        'scope': _cidaasProvider.cidaasConf.scopes,
        'redirect_uri': '${_cidaasProvider.cidaasConf.baseUrl}/bildungscampus',
        'prompt': 'none'
      };
      final url =
          Uri.parse('${_cidaasProvider.cidaasConf.baseUrl}/authz-srv/authz')
              .replace(queryParameters: queryStrings);

      log("renewSsoCookie: $url");

      Cookie? ssoCookie =
          storedToken!.ssoCookie != null && storedToken.ssoCookie!.isNotEmpty
              ? Cookie.fromSetCookieValue(storedToken.ssoCookie!)
              : null;
      Cookie? ssoCookie2 =
          storedToken.ssoCookie != null && storedToken.ssoCookie!.isNotEmpty
              ? Cookie.fromSetCookieValue(storedToken.ssoCookie!)
              : null;

      ssoCookie2?.name = "cidaas_rl";

      final Map<String, String> headers = storedToken.ssoCookie != null
          ? {'cookie': '$ssoCookie;$ssoCookie2'}
          : {};

      log(headers.toString());

      final response = await http.post(
        url,
        headers: headers,
      );

      final cookies = response.headers['set-cookie'];
      if (cookies == null || cookies.isEmpty) {
        return;
      }

      final newSsoCookieValue = _getSsoCookieFromCookies(cookies);
      log('newSsoCookie: $newSsoCookieValue');

      storedToken.ssoCookie = newSsoCookieValue;
      _ssoCookie = newSsoCookieValue;

      _cidaasProvider.authStorageHelper.persistTokenEntity(storedToken);
    } catch (e) {
      log(e.toString());
    }
  }

  static final _regexSplitSetCookies = RegExp(',(?=[^ ])');

  String _getSsoCookieFromCookies(String input) {
    final cookies = input.split(_regexSplitSetCookies);
    final ssoCookie = cookies.firstWhere((c) => c.startsWith('cidaas_sso'));

    return ssoCookie;
  }

  bool _isRefreshTokenExpired(String refreshToken) {
    if (refreshToken.split('.').length != 3) {
      //Invalid access_token
      return true;
    }
    final String decClaimSet = _decodeBase64(refreshToken.split('.')[1]);
    final dynamic tokenInfo = json.decode(decClaimSet);
    final DateTime expiresAt =
        DateTime.fromMillisecondsSinceEpoch(tokenInfo['exp'] * 1000);
    final Duration difference = expiresAt.difference(DateTime.now());
    return (difference.inSeconds < 60) ? true : false;
  }

  /// Decodes the given base64 string [str]
  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
