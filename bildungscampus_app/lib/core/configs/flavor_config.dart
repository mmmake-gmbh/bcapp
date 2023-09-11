import 'package:flutter/material.dart';
import '../utils/string_utils.dart';

enum Flavor { dev, production }

class FlavorValues {
  //Add other flavor specific values, e.g database name, service Urls
  final String apiGatewayUrl;
  final String identityServerUrl;
  final String identityClientId;
  final String identityClientSecret;
  final String identityScheme;
  final bool useIdentity;

  FlavorValues({
    required this.apiGatewayUrl,
    required this.identityServerUrl,
    required this.identityClientId,
    required this.identityClientSecret,
    required this.identityScheme,
    required this.useIdentity,
  });
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig? _instance;

  static FlavorConfig? get instance {
    return _instance;
  }

  factory FlavorConfig({
    required Flavor flavor,
    Color color = Colors.blue,
    required FlavorValues values,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      StringUtils.enumName(flavor.toString()),
      color,
      values,
    );
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  static bool isProduction() => _instance!.flavor == Flavor.production;
  static bool isDevelopment() => _instance!.flavor == Flavor.dev;
}
