import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/bike_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/booksearch_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/campus_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/fourty_two_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/locationmap_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/mensa_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/parking_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/payment_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/timetable_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/weather_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/welcome_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/shared/svg_icons.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/mensa_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/parking_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/start_tile.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/text_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/weather_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/welcome_tile.dart';
import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TileUtils {
  static Widget mapTile(
      BaseStartTileViewModel model, Locale? locale, BuildContext context) {
    if (model is WelcomeTileViewModel) {
      final args = ModalRoute.of(context)!.settings.arguments as TokenEntity?;
      return WelcomeTile(firstLogin: args?.ssoCookie != null);
    } else if (model is WeatherTileViewModel) {
      const textColor = AppColors.weatherTileTextColor;
      return StartTile.withBaseModel(
        model,
        locale: locale,
        bgColor: AppColors.weatherTileBgColor.withOpacity(0.85),
        showHeader: false,
        isFullTileTap: false,
        padding:
            const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
        isFeatureInfoShown:
            _isFeatureInfoShown(context, model.featureInfo, model.featureType),
        child: Consumer<AppViewModel>(
          builder: (ctx, appModel, _) => WeatherTileContent(
            model: appModel.currentWeather,
            textColor: textColor,
          ),
        ),
      );
    } else if (model is MensaTileViewModel) {
      return StartTile.withBaseModel(
        model,
        locale: locale,
        bgColor: AppColors.primaryTwoColor,
        isFullTileTap: false,
        isFeatureInfoShown:
            _isFeatureInfoShown(context, model.featureInfo, model.featureType),
        child: MensaTileContent(
          weeklyMenu: model.weeklyMenu,
          activeTabColor: AppColors.primaryOneColor,
          contentColor: Colors.white,
          unselectedTabColor: Colors.white,
        ),
      );
    } else if (model is ParkingTileViewModel) {
      onTapFunction() => Navigator.of(context).pushNamed(AppRouter.parkingRoute,
          arguments: model.selectedParkingCategory!);

      return ChangeNotifierProvider<ParkingTileViewModel>.value(
        value: model,
        builder: (ctx, child) => StartTile.withBaseModel(
          model,
          locale: locale,
          bgColor: AppColors.parkingTileBgColor,
          isFullTileTap: false,
          onTap: onTapFunction,
          isFeatureInfoShown: _isFeatureInfoShown(
              context, model.featureInfo, model.featureType),
          child: Consumer<ParkingTileViewModel>(
            builder: (ctx, model, _) => ParkingTileContent(
              parkingCategories: model.parkingCategories,
              contentColor: Colors.white,
              buttonText: S.of(context).tiles_button_text_more,
              buttonTextColor: Colors.white,
              onTap: onTapFunction,
            ),
          ),
        ),
      );
    } else if (model is CampusTileViewModel) {
      return StartTile.withTextContent(
        model,
        locale: locale,
        bgColor: AppColors.campusTileBgColor,
        contentColor: Colors.white,
        isFullTileTap: true,
        isFeatureInfoShown:
            _isFeatureInfoShown(context, model.featureInfo, model.featureType),
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is TimetableTileViewModel) {
      return StartTile.withTextContent(
        model,
        locale: locale,
        bgColor: AppColors.timetableTileBgColor,
        contentColor: Colors.white,
        isFullTileTap: true,
        isFeatureInfoShown:
            _isFeatureInfoShown(context, model.featureInfo, model.featureType),
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is LocationMapTileViewModel) {
      return StartTile.withTextContent(
        model,
        locale: locale,
        contentColor: Colors.white,
        bgColor: AppColors.primaryTwoColor,
        isFullTileTap: true,
        isFeatureInfoShown:
            _isFeatureInfoShown(context, model.featureInfo, model.featureType),
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is BookSearchTileViewModel) {
      return StartTile.withTextContent(
        model,
        locale: locale,
        bgColor: AppColors.primaryTwoColor,
        contentColor: Colors.white,
        isFullTileTap: true,
        isFeatureInfoShown:
            _isFeatureInfoShown(context, model.featureInfo, model.featureType),
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is FourtytwoTileViewModel) {
      return StartTile.withTextContent(
        model,
        locale: locale,
        bgColor: AppColors.fourtyTwoTileTextBgColor,
        contentColor: Colors.white,
        isFullTileTap: true,
        isFeatureInfoShown:
            _isFeatureInfoShown(context, model.featureInfo, model.featureType),
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is PaymentTileViewModel) {
      const contentColor = Colors.white;

      return Consumer<UserViewModel>(
        builder: ((context, userViewModel, _) {
          if (userViewModel.isLogged) {
            return StartTile.withTextContent(
              model,
              locale: locale,
              bgColor: AppColors.campusCardTileBgColor,
              contentColor: contentColor,
              isFullTileTap: true,
              isFeatureInfoShown: _isFeatureInfoShown(
                  context, model.featureInfo, model.featureType),
              onTap: () {
                Navigator.of(context).pushNamed(model.navigationPath);
              },
            );
          }

          return StartTile(
            titleColor: contentColor,
            tileTitle: S.of(context).login_tile_title,
            iconPath: SvgIcons.pin,
            isFullTileTap: true,
            maxTitleLines: 1,
            backgroundColor: AppColors.primaryOneColor,
            child: TextTileContent(
                textColor: contentColor,
                text: S.of(context).login_tile_text,
                textAlignment: TextAlign.center,
                buttonText: S.of(context).login_tile_button_text,
                buttonTextColor: contentColor),
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pushNamed(
                AppRouter.loginRoute,
                arguments: AppRouter.paymentRoute,
              );
            },
          );
        }),
      );
    } else if (model is BikeTileViewModel) {
      const contentColor = Colors.white;

      return Consumer<UserViewModel>(
        builder: ((context, userViewModel, _) {
          if (userViewModel.isLogged) {
            return StartTile.withTextContent(
              model,
              locale: locale,
              bgColor: AppColors.campusCardTileBgColor,
              contentColor: contentColor,
              isFullTileTap: true,
              isFeatureInfoShown: _isFeatureInfoShown(
                  context, model.featureInfo, model.featureType),
              onTap: () {
                Navigator.of(context).pushNamed(model.navigationPath);
              },
            );
          }

          return StartTile(
            titleColor: contentColor,
            tileTitle: S.of(context).login_tile_title,
            iconPath: SvgIcons.pin,
            isFullTileTap: true,
            maxTitleLines: 1,
            backgroundColor: AppColors.primaryOneColor,
            child: TextTileContent(
                textColor: contentColor,
                text: S.of(context).login_tile_text,
                textAlignment: TextAlign.center,
                buttonText: S.of(context).login_tile_button_text,
                buttonTextColor: contentColor),
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pushNamed(
                AppRouter.loginRoute,
                arguments: AppRouter.paymentRoute,
              );
            },
          );
        }),
      );
    }
    return Container();
  }

  static Future<bool?> _isFeatureInfoShown(BuildContext context,
      FeatureInfo featureInfo, FeatureType featureType) async {
    final shouldBeShown = await context
        .read<AppViewModel>()
        .shouldShowFeatureInfo(featureType, featureInfo);
    return shouldBeShown;
  }
}
