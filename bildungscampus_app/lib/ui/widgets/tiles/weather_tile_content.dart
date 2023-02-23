import 'package:auto_size_text/auto_size_text.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/weather/weather_data.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherTileContent extends StatelessWidget {
  final WeatherData? model;
  final Color textColor;

  WeatherTileContent({
    required this.model,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).home_view_tiles_weather_title,
          style: TextStyle(
            color: textColor,
            fontSize: 16.0,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              SvgIcons.arrowRight,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              height: 13.0,
              width: 12.0,
            ),
            if (model != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        model!.getWeatherText(context),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14.0,
                          letterSpacing: 0.1,
                        ),
                        maxLines: 1,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            SvgIcons.weather,
                            colorFilter:
                                ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            height: 30.0,
                            width: 30.0,
                          ),
                          Text(
                            '${model!.value.round()} ${model!.unit}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 26.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
          ],
        )
      ],
    );
  }
}
