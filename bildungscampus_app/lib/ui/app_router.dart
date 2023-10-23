import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/models/settings/setting_view_args.dart';
import 'package:bildungscampus_app/ui/views/book_search_view.dart';
import 'package:bildungscampus_app/ui/views/contact_view.dart';
import 'package:bildungscampus_app/ui/views/fourty_two_view.dart';
import 'package:bildungscampus_app/ui/views/location_map_view.dart';
import 'package:bildungscampus_app/ui/views/login_view.dart';
import 'package:bildungscampus_app/ui/views/payment_view.dart';
import 'package:bildungscampus_app/ui/views/privacy_view.dart';
import 'package:bildungscampus_app/ui/views/setting_view.dart';
import 'package:bildungscampus_app/ui/views/setting_web_view.dart';
import 'package:bildungscampus_app/ui/views/timetable_view.dart';
import 'package:flutter/material.dart';
import 'package:bildungscampus_app/ui/views/intro_view.dart';
import 'package:bildungscampus_app/ui/views/parking_view.dart';
import 'package:bildungscampus_app/ui/views/home_view.dart';
import 'package:bildungscampus_app/ui/widgets/common/flavor_banner.dart';
import 'package:bildungscampus_app/core/configs/flavor_config.dart';

class AppRouter {
  static const String initialRoute = "/initial";
  static const String homeRoute = "/";
  static const String parkingRoute = "/parking";
  static const String privacyRoute = "/privacy";
  static const String timetableRoute = "/timetable";
  static const String locationMapRoute = "/locationmap";
  static const String bookSearchRoute = "/booksearch";
  static const String paymentRoute = "/payment";
  static const String contactRoute = "/contact";
  static const String loginRoute = "/login";
  static const String settingRoute = "/setting";
  static const String settingWebRoute = "/setting-web";
  static const String fourtyTwoRoute = "/fourtytwo";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(const IntroView()),
          settings: settings,
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(const HomeView()),
          settings: settings,
        );
      case parkingRoute:
        final args = settings.arguments as ParkingLotCategory?;

        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(ParkingView(
            preselectedCategory: args,
          )),
          settings: settings,
        );
      case privacyRoute:
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(const PrivacyView()),
          settings: settings,
        );
      case timetableRoute:
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(const TimeTableView()),
          settings: settings,
        );
      case locationMapRoute:
        return MaterialPageRoute(
          builder: (_) =>
              _setupProvidersAndFlavorBanner(const LocationMapView()),
          settings: settings,
        );
      case bookSearchRoute:
        return MaterialPageRoute(
          builder: (_) =>
              _setupProvidersAndFlavorBanner(const BookSearchView()),
          settings: settings,
        );
      case paymentRoute:
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(const PaymentView()),
          settings: settings,
        );
      case contactRoute:
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(const ContactView()),
          settings: settings,
        );
      case loginRoute:
        final args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(
            LoginView(
              navigationPath: args,
            ),
          ),
          settings: settings,
        );
      case settingRoute:
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(const SettingView()),
          settings: settings,
        );
      case settingWebRoute:
        final args = settings.arguments as SettingViewArgs?;
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(
            SettingWebView(
              url: args?.url,
              title: args?.title,
            ),
          ),
          settings: settings,
        );
      case fourtyTwoRoute:
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(const FourtyTwoView()),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => _setupProvidersAndFlavorBanner(const HomeView()),
          settings: settings,
        );
    }
  }

  static Widget _setupProvidersAndFlavorBanner(Widget child) {
    return FlavorBanner(
        bannerName: FlavorConfig.instance!.name,
        bannerColor: FlavorConfig.instance!.color,
        child: child);
  }
}
