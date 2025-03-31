import 'dart:developer';
import 'dart:io';

import 'package:bildungscampus_app/core/configs/flavor_config.dart';
import 'package:bildungscampus_app/core/services/interfaces/auth_service.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:oauth2_client/access_token_response.dart';

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage({required this.imagePath, super.key});

  final String imagePath;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  final AuthService _authService = locator<AuthService>();

  late final Future<AccessTokenResponse>? accessTokenFuture;

  @override
  void initState() {
    super.initState();

    accessTokenFuture = FlavorConfig.instance!.values.useIdentity
        ? _authService.getAccessToken()
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final baseUrl = FlavorConfig.instance!.values.apiGatewayUrl;

    return FutureBuilder(
        future: accessTokenFuture,
        builder: (context, tokenResponseSnapshot) {
          if (tokenResponseSnapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final token = tokenResponseSnapshot.data?.accessToken ?? "";

          if (token.isEmpty) {
            return const SizedBox.shrink();
          }

          final imageUrl =
              "$baseUrl/content-info/GetImage?filepath=${Uri.encodeFull(widget.imagePath)}";

          return Image.network(
            imageUrl,
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              log("error durring loading an image: $error, stackTrace: $stackTrace");
              return const Icon(Icons.error);
            },
          );
        });
  }
}
