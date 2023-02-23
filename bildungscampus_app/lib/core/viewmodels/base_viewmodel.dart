import 'package:flutter/foundation.dart';

import 'package:bildungscampus_app/core/enums/viewstate.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Initial;

  bool get isBusy => _state == ViewState.Busy;

  bool get hasError => _state == ViewState.Error;

  void setState(ViewState viewState, {bool silently = false}) {
    if (_state != viewState) {
      _state = viewState;
      if (!silently) {
        notifyListeners();
      }
    }
  }
}
