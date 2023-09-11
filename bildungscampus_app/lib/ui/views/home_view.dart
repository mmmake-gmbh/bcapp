import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/base_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/booksearch_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/locationmap_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/payment_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/timetable_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/widgets/common/standard_error_dialog.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/text_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/welcome_tile.dart';
import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:bildungscampus_app/ui/widgets/tiles/start_tile.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/mensa_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/parking_tile_content.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/weather_tile_content.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';

import '../shared/svg_icons.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  bool previewStateHasError = false;
  Timer? timer;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<StaggeredGridTile> _getTiles(
      List<BaseViewModel> tiles, BuildContext context) {
    final newTiles = [...tiles];

    newTiles.insert(
        0,
        BaseStartTileViewModel(
            title: 'welcome',
            iconPath: 'iconPath',
            navigationPath: 'navigationPath',
            type: TileType.wideSmall,
            maxTitleLines: 2)); //TODO: Move this to the json config

    return newTiles.map((model) {
      final tileModel = model as BaseStartTileViewModel;
      final tileWidget = _mapTile(
        tileModel,
        context,
      );

      switch (tileModel.type) {
        case TileType.small:
          return StaggeredGridTile.count(
              crossAxisCellCount: 2, mainAxisCellCount: 1, child: tileWidget);
        case TileType.big:
          return StaggeredGridTile.count(
              crossAxisCellCount: 2, mainAxisCellCount: 2, child: tileWidget);
        case TileType.wide:
          return StaggeredGridTile.count(
              crossAxisCellCount: 4, mainAxisCellCount: 2, child: tileWidget);
        case TileType.wideSmall:
          return StaggeredGridTile.count(
              crossAxisCellCount: 4, mainAxisCellCount: 1, child: tileWidget);
      }
    }).toList();
  }

  Widget _mapTile(BaseStartTileViewModel model, BuildContext context) {
    if (model is WeatherTileViewModel) {
      const textColor = AppColors.weatherTileTextColor;
      return StartTile.withBaseModel(
        model,
        bgColor: AppColors.weatherTileBgColor.withOpacity(0.85),
        showHeader: false,
        isFullTileTap: false,
        padding:
            const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
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
      onTapFunction() => Navigator.of(context).pushNamed(AppRouter.parkingRoute,
          arguments: model.selectedParkingCategory!.key);

      return ChangeNotifierProvider<ParkingTileViewModel>.value(
        value: model,
        builder: (ctx, child) => StartTile.withBaseModel(
          model,
          bgColor: AppColors.parkingTileBgColor,
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
      const contentColor = Colors.white;
      return StartTile.withTextContent(
        model,
        bgColor: AppColors.timetableTileBgColor,
        contentColor: contentColor,
        isFullTileTap: true,
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is LocationMapTileViewModel) {
      const contentColor = Colors.white;

      return StartTile.withTextContent(
        model,
        contentColor: contentColor,
        bgColor: AppColors.primaryTwoColor,
        isFullTileTap: true,
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model is BookSearchTileViewModel) {
      const contentColor = Colors.white;
      return StartTile.withTextContent(
        model,
        bgColor: AppColors.primaryTwoColor,
        contentColor: contentColor,
        isFullTileTap: true,
        onTap: () {
          Navigator.of(context).pushNamed(model.navigationPath);
        },
      );
    } else if (model.title == 'welcome') {
      final args = ModalRoute.of(context)!.settings.arguments as TokenEntity?;
      return WelcomeTile(firstLogin: args?.ssoCookie != null);
    } else if (model is PaymentTileViewModel) {
      const contentColor = Colors.white;

      return Consumer<UserViewModel>(
        builder: ((context, userViewModel, _) {
          if (userViewModel.isLogged) {
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

          return StartTile(
            titleColor: Colors.white,
            tileTitle: S.of(context).login_tile_title,
            iconPath: SvgIcons.pin,
            isFullTileTap: true,
            maxTitleLines: 1,
            backgroundColor: AppColors.primaryOneColor,
            child: TextTileContent(
              textColor: Colors.white,
              text: S.of(context).login_tile_text,
              textAlignment: TextAlign.center,
              buttonText: S.of(context).login_tile_button_text,
              buttonTextColor: Colors.white,
            ),
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pushNamed('/login');
            },
          );
        }),
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
    timer = Timer.periodic(const Duration(seconds: 45),
        (Timer t) => appViewModel.updateSilently(context));
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
              return const StandardErrorDialog();
            },
          ));
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: ReusableAppBars.lightAppBarWithLogo(
        context,
        scaffoldKey: scaffoldKey,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              SvgIcons.accountCircleFilled,
              height: 32,
              alignment: Alignment.center,
              colorFilter: const ColorFilter.mode(
                  AppColors.homeAppBarColor, BlendMode.srcIn),
            ),
            tooltip: S.of(context).home_view_setting_button_tooltip,
            onPressed: () {
              final isLogged = context.read<UserViewModel>().isLogged;

              final route =
                  isLogged ? AppRouter.settingRoute : AppRouter.loginRoute;
              Navigator.of(context).pushNamed(route);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              Image.asset(
                AppImages.startScreen,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Consumer<AppViewModel>(builder: (context, model, child) {
                if (model.isBusy) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (model.tiles == null) {
                  return const SizedBox.shrink();
                }

                return Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 50,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: Platform.isIOS
                          ? const AlwaysScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      child: StaggeredGrid.count(
                        crossAxisCount: 4,
                        axisDirection: AxisDirection.down,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        children: _getTiles(model.tiles!, context),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
