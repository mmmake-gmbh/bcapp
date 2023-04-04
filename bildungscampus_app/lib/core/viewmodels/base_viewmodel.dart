import 'package:flutter/foundation.dart';

import 'package:bildungscampus_app/core/enums/viewstate.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.initial;

  bool get isBusy => _state == ViewState.busy;

  bool get hasError => _state == ViewState.error;

  void setState(ViewState viewState, {bool silently = false}) {
    if (_state != viewState) {
      _state = viewState;
      if (!silently) {
        notifyListeners();
      }
    }
  }
}
