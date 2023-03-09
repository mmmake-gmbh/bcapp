import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:bildungscampus_app/core/configs/flavor_config.dart';
import 'package:bildungscampus_app/core/services/interfaces/auth_service.dart';

class OAuthAuthService extends AuthService {
  late OAuth2Helper _helper;

  OAuthAuthService() {
    final identityServerUrl = FlavorConfig.instance!.values.identityServerUrl;

    _helper = OAuth2Helper(
      OAuth2Client(
        authorizeUrl: '$identityServerUrl/connect/authorize',
        customUriScheme: FlavorConfig.instance!.values.identityScheme,
        redirectUri:
            '${FlavorConfig.instance!.values.identityScheme}://oauth2redirect',
        tokenUrl: '$identityServerUrl/connect/token',
        refreshUrl: '$identityServerUrl/connect/token',
      ),
      clientId: FlavorConfig.instance!.values.identityClientId,
      clientSecret: FlavorConfig.instance!.values.identityClientSecret,
      scopes: ['mobile'],
      grantType: OAuth2Helper.clientCredentials,
    );
  }

  Future<AccessTokenResponse> _getToken() async {
    var tknStorage = await _helper.getTokenFromStorage();
    AccessTokenResponse tknResp;

    if (tknStorage == null || tknStorage.refreshNeeded()) {
      tknResp = await _helper.fetchToken();
    } else {
      tknResp = tknStorage;
    }

    if (!tknResp.isValid()) {
      throw Exception(
          'Provider error ${tknResp.httpStatusCode}: ${tknResp.error}: ${tknResp.errorDescription}');
    }

    if (!tknResp.isBearer()) {
      throw Exception('Only Bearer tokens are currently supported');
    }

    return tknResp;
  }

  @override
  Future<AccessTokenResponse> getAccessToken() async {
    final accessToken = await _getToken();
    return accessToken;
  }
}
