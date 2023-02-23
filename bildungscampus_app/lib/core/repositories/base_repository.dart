import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:bildungscampus_app/core/configs/flavor_config.dart';
import 'package:bildungscampus_app/core/services/interfaces/auth_service.dart';
import 'package:bildungscampus_app/locator.dart';

abstract class BaseRepository<T> {
  AuthService _authService = locator<AuthService>();

  Future<dynamic> _getJsonContent(String urlPath) async {
    if (!urlPath.startsWith("/")) {
      throw ("BaseRepository: urlPath not starting with a slash: $urlPath");
    }

    final url = FlavorConfig.instance!.values.apiGatewayUrl + urlPath;
    final token = await _authService.getAccessToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer ${token.accessToken}"},
    );

    final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonResponse;
  }

  Future<T> getItem(String urlPath) async {
    final content = await _getJsonContent(urlPath);

    final returnObject = mapFromJson(content);
    return returnObject;
  }

  Future<List<T>> getItems(String urlPath) async {
    final content = await _getJsonContent(urlPath);

    final jsonList = content as List;
    final returnObject = jsonList.map((e) => mapFromJson(e)).toList();
    return returnObject;
  }

  T mapFromJson(dynamic jsonResponse);
}
