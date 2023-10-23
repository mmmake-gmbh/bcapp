import 'dart:async';
import 'dart:io';

import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/utils/tile_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/base_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/widgets/common/new_flag.dart';
import 'package:bildungscampus_app/ui/widgets/common/standard_error_dialog.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:bildungscampus_app/core/enums/tile_type.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/base_start_tile_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/app_drawer.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';

import '../shared/svg_icons.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  bool initialStateHasError = false;
  Timer? timer;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<StaggeredGridTile> _getTiles(
      List<BaseViewModel> tiles, Locale? locale, BuildContext context) {
    final newTiles = [...tiles];

    return newTiles.map((model) {
      final tileModel = model as BaseStartTileViewModel;
      final tileWidget = TileUtils.mapTile(
        tileModel,
        locale,
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    final appViewModel = context.read<AppViewModel>();

    Future.microtask(() => appViewModel.load(context));
    startTimer();
    initialStateHasError = false;
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

    if (hasError && !initialStateHasError) {
      //TODO: Fix this strange logic
      setState(() {
        initialStateHasError = true;
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
      body: Stack(
        children: [
          SafeArea(
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
                  Consumer2<AppViewModel, UserViewModel>(
                      builder: (context, model, userModel, child) {
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
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            top: 50, left: 12.0, right: 12.0),
                        scrollDirection: Axis.vertical,
                        physics: Platform.isIOS
                            ? const AlwaysScrollableScrollPhysics()
                            : const BouncingScrollPhysics(),
                        child: StaggeredGrid.count(
                          crossAxisCount: 4,
                          axisDirection: AxisDirection.down,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                          children: _getTiles(
                              model.tiles!, userModel.locale, context),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Selector<AppViewModel, FeatureInfo>(
            builder: (context, featureInfo, _) => NewFlag(
              featureInfo: featureInfo,
              featureType: FeatureType.home,
            ),
            selector: (context, model) => model.overallFeatureInfo,
          ),
        ],
      ),
    );
  }
}
