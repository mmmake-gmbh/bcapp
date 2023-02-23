import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/base_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/booksearch_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/locationmap_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/payment_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/timetable_tile_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/widgets/common/standard_error_dialog.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/locationmap_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/start_tile_extended.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:bildungscampus_app/core/enums/tile_type.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/campus_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/mensa_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/parking_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/weather_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/app_drawer.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/start_tile.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/mensa_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/parking_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/weather_tile_content.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  bool previewStateHasError = false;
  Timer? timer;

  List<StaggeredGridTile> _getTiles(
      List<BaseViewModel> tiles, BuildContext context) {
    return tiles.map((model) {
      final tileModel = model as BaseStartTileViewModel;
      final tileWidget = _mapTile(
        tileModel,
        context,
      );

      switch (tileModel.type) {
        case TileType.Small:
          return StaggeredGridTile.count(
              crossAxisCellCount: 2, mainAxisCellCount: 1, child: tileWidget);
        case TileType.Big:
          return StaggeredGridTile.count(
              crossAxisCellCount: 2, mainAxisCellCount: 2, child: tileWidget);
        case TileType.Wide:
          return StaggeredGridTile.count(
              crossAxisCellCount: 4, mainAxisCellCount: 2, child: tileWidget);
      }
    }).toList();
  }

  Widget _mapTile(BaseStartTileViewModel model, BuildContext context) {
    if (model is WeatherTileViewModel) {
      final textColor = Colors.white;
      return StartTile.withBaseModel(
        model,
        bgColor: AppColors.weatherTileBgColor.withOpacity(0.72),
        showHeader: false,
        isFullTileTap: false,
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
        bgColor: AppColors.primaryTwoColor,
        isFullTileTap: false,
        child: MensaTileContent(
          weeklyMenu: model.weeklyMenu,
          activeTabColor: AppColors.primaryOneColor,
          contentColor: Colors.white,
          unselectedTabColor: Colors.white,
        ),
      );
    } else if (model is ParkingTileViewModel) {
      final Function onTapFunction = () => Navigator.of(context).pushNamed(
          AppRouter.parkingRoute,
          arguments: model.selectedParkingCategory!.key);

      return ChangeNotifierProvider<ParkingTileViewModel>.value(
        value: model,
        builder: (ctx, child) => StartTile.withBaseModel(
          model,
          bgColor: AppColors.primaryOneColor,
          isFullTileTap: false,
          onTap: onTapFunction,
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
        bgColor: AppColors.campusTileBgColor,
        contentColor: Colors.white,
        isFullTileTap: true,
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is TimetableTileViewModel) {
      final contentColor = Colors.white;
      return StartTile.withTextContent(
        model,
        bgColor: AppColors.primaryOneColor,
        contentColor: contentColor,
        isFullTileTap: true,
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is LocationMapTileViewModel) {
      final contentColor = AppColors.primaryOneColor;

      return StartTileExtended.withBaseModel(
        model,
        contentColor: contentColor,
        bgColor: AppColors.locationMapBgColor,
        isFullTileTap: true,
        child: LocationMapTileContent.withModel(
          model,
          contentColor: contentColor,
          onTap: () {
            Navigator.of(context).pushNamed(model.navigationPath);
          },
        ),
      );
    } else if (model is BookSearchTileViewModel) {
      final contentColor = Colors.white;
      return StartTile.withTextContent(
        model,
        bgColor: AppColors.secondaryTwoColor,
        contentColor: contentColor,
        isFullTileTap: true,
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is PaymentTileViewModel) {
      final contentColor = Colors.white;
      return StartTile.withTextContent(
        model,
        bgColor: AppColors.campusCardTileBgColor,
        contentColor: contentColor,
        isFullTileTap: true,
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    }
    return Container();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    final appViewModel = context.read<AppViewModel>();

    Future.microtask(() => appViewModel.load(context));
    startTimer();
    previewStateHasError = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log(state.toString());

    switch (state) {
      case AppLifecycleState.paused:
        cancelTimer();
        break;
      case AppLifecycleState.resumed:
        startTimer();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        cancelTimer();
        break;
    }
  }

  void startTimer() {
    final appViewModel = context.read<AppViewModel>();

    cancelTimer();
    timer = Timer.periodic(Duration(seconds: 45),
        (Timer t) => appViewModel.updateSilently(context));
    appViewModel.updateSilently(context, updateAll: true);
  }

  void cancelTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = context.select<AppViewModel, bool>((vm) => vm.hasError);

    if (hasError && !previewStateHasError) {
      setState(() {
        previewStateHasError = true;
      });
      Future.microtask(() => showDialog(
            context: context,
            builder: (ct) {
              return StandardErrorDialog();
            },
          ));
    }

    return Scaffold(
      appBar: ReusableAppBars.transparentAppBar(),
      drawer: AppDrawer(),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              AppImages.startScreen,
              height: 340,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Consumer<AppViewModel>(builder: (context, model, child) {
              if (model.isBusy) {
                return Center(child: CircularProgressIndicator());
              }

              if (model.tiles == null) {
                return SizedBox.shrink();
              }

              return Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: Platform.isIOS
                        ? AlwaysScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      axisDirection: AxisDirection.down,
                      children: _getTiles(model.tiles!, context),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
