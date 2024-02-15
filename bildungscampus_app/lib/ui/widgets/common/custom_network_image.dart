import 'dart:developer';
import 'dart:io';

import 'package:bildungscampus_app/core/configs/flavor_config.dart';
import 'package:bildungscampus_app/core/services/interfaces/auth_service.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          final token = tokenResponseSnapshot.data?.accessToken ?? "";

          if (token.isEmpty) {
            return const SizedBox.shrink();
          }

          return CachedNetworkImage(
            imageUrl:
                "$baseUrl/content-info/GetImage?filepath=${Uri.encodeFull(widget.imagePath)}",
            httpHeaders: {HttpHeaders.authorizationHeader: "Bearer $token"},
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            errorListener: (value) {
              log(value.toString());
            },
          );
        });
  }
}
