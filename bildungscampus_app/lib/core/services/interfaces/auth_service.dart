import 'package:oauth2_client/access_token_response.dart';

abstract class AuthService {
  Future<AccessTokenResponse> getAccessToken();
}
