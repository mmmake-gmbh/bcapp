import 'dart:developer';
import 'dart:io';

import 'package:bildungscampus_app/core/configs/flavor_config.dart';
import 'package:bildungscampus_app/core/services/interfaces/auth_service.dart';
import 'package:bildungscampus_app/locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage({required this.imagePath, super.key});

  final String imagePath;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  String? accessToken;
  final AuthService _authService = locator<AuthService>();

  @override
  void initState() {
    super.initState();

    if (FlavorConfig.instance!.values.useIdentity) {
      _authService.getAccessToken().then((token) {
        setState(() {
          accessToken = token.accessToken ?? "";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseUrl = FlavorConfig.instance!.values.apiGatewayUrl;

    return CachedNetworkImage(
      imageUrl:
          "$baseUrl/content-info/GetImage?filepath=${Uri.encodeFull(widget.imagePath)}",
      httpHeaders: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      errorListener: (value) {
        log(value.toString());
      },
    );
  }
}
