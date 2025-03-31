import 'package:bildungscampus_app/core/enums/feature_type.dart';
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
import 'package:bildungscampus_app/core/viewmodels/tiles/service_desk_tile_view_model.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/text_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/timetable_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/welcome_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/start_tile.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/welcome_tile.dart';
import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TileUtils {
  static Widget mapTile(
      BaseStartTileViewModel model, Locale? locale, BuildContext context) {
    /*if (model is WelcomeTileViewModel) {
      final args = ModalRoute.of(context)!.settings.arguments as TokenEntity?;
      return WelcomeTile(firstLogin: args?.ssoCookie != null);
    } else */
    if (model is MensaTileViewModel) {
      return StartTile.withTextContent(
        model,
        locale: locale,
        bgColor: AppColors.mensaBgColor,
        contentColor: Colors.white,
        isFullTileTap: true,
        isFeatureInfoShown:
            _isFeatureInfoShown(context, model.featureInfo, model.featureType),
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is ParkingTileViewModel) {
      return StartTile.withTextContent(
        model,
        locale: locale,
        bgColor: AppColors.parkingTileBgColor,
        contentColor: Colors.white,
        isFullTileTap: true,
        isFeatureInfoShown:
            _isFeatureInfoShown(context, model.featureInfo, model.featureType),
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
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
    } else if (model is PaymentTileViewModel ||
        model is BikeTileViewModel ||
        model is ServiceDeskTileViewModel) {
      return Consumer<UserViewModel>(
        builder: ((context, userViewModel, _) {
          if (userViewModel.isLogged) {
            return StartTile.withTextContent(
              model as TextTileViewModel,
              locale: locale,
              bgColor: AppColors.campusCardTileBgColor,
              contentColor: Colors.white,
              isFullTileTap: true,
              isFeatureInfoShown: _isFeatureInfoShown(
                  context, model.featureInfo, model.featureType),
              onTap: () {
                Navigator.of(context).pushNamed(model.navigationPath);
              },
            );
          }

          return const SizedBox.shrink();
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
