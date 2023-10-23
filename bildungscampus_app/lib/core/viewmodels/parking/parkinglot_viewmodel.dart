import 'dart:io';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:bildungscampus_app/core/models/parking/parkinglot.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ParkingLotViewModel extends ChangeNotifier {
  final ParkingLotV2 parkingLot;
  bool _isExpanded;

  bool get isExpanded => _isExpanded;

  ParkingLotViewModel({required this.parkingLot}) : _isExpanded = false;

  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  Future<bool> navigateTo() async {
    String query = '${parkingLot.street}, ${parkingLot.city}';
    final fallbackUri =
        Uri.https('maps.google.com', '/maps', {'q': query}).toString();

    String uri;
    if (Platform.isAndroid) {
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query})
          .toString();
    } else if (Platform.isIOS) {
      // More info: https://stackoverflow.com/questions/47046637/open-google-maps-app-if-available-with-flutter
      uri = Uri(
          scheme: 'comgooglemaps',
          host: '',
          queryParameters: {'daddr': query}).toString();
    } else {
      uri = fallbackUri;
    }

    log('query: $query');
    log('uri: $uri');

    if (await canLaunchUrlString(uri)) {
      return launchUrlString(uri);
    }

    log('fallbackUri: $fallbackUri');

    if (await canLaunchUrlString(fallbackUri)) {
      return launchUrlString(fallbackUri);
    }

    return false;
  }
}
