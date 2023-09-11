import 'package:flutter/material.dart';
import 'package:bildungscampus_app/core/configs/flavor_config.dart';

class FlavorBanner extends StatelessWidget {
  final Widget child;
  final String? bannerName;
  final Color? bannerColor;
  const FlavorBanner(
      {Key? key, required this.child, this.bannerName, this.bannerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FlavorConfig.isProduction()) return child;
    return Stack(
      children: <Widget>[child, _buildBanner(context)],
    );
  }

  Widget _buildBanner(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: CustomPaint(
        painter: BannerPainter(
            message: bannerName!,
            textDirection: Directionality.of(context),
            layoutDirection: Directionality.of(context),
            location: BannerLocation.topStart,
            color: bannerColor!),
      ),
    );
  }
}
