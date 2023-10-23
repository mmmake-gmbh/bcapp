import 'package:auto_size_text/auto_size_text.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherTileContent extends StatelessWidget {
  final WeatherData? model;
  final Color textColor;

  const WeatherTileContent({
    Key? key,
    required this.model,
    required this.textColor,
  }) : super(key: key);

  String _getWeatherIcon(WeatherData data) {
    if (data.isRaining && data.value <= 0) {
      return SvgIcons.weatherSnowy;
    } else if (data.isRaining && data.value > 0) {
      return SvgIcons.weatherRainy;
    }
    return SvgIcons.weatherSonny;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).home_view_tiles_weather_title,
            style: TextStyle(
                color: textColor, fontSize: 12.0, fontFamily: 'DINOT Bold'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 2.0),
                  child: SvgPicture.asset(
                    SvgIcons.arrowRight,
                    colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                    height: 10.0,
                    width: 10.0,
                  ),
                ),
                if (model != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            model!.getWeatherText(context),
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12.0,
                              fontFamily: 'DINOT Light',
                              letterSpacing: 0.1,
                            ),
                            maxLines: 1,
                          ),
                          Transform.translate(
                            offset: const Offset(-1.0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    '${model!.value.round()} ${model!.unit}',
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: 24.0,
                                        fontFamily: 'DINOT Bold'),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      if (model != null)
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(
            _getWeatherIcon(model!),
            colorFilter: const ColorFilter.mode(
                AppColors.weatherIconColor, BlendMode.srcIn),
            height: 35.0,
            width: 35.0,
          ),
        )
    ]);
  }
}
