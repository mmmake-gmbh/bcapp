import 'package:flutter/foundation.dart';

class PlayerData extends ChangeNotifier {
  // Keeps track of current score.
  // If game is not running, this will
  // represent score of last round.
  int _currentScore = 0;

  int get currentScore => _currentScore;

  set currentScore(int newScore) {
    _currentScore = newScore;
    // While setting currentScore to a new value
    // also make sure to update highScore.
    if (_highScore < _currentScore) {
      _highScore = _currentScore;
    }
  }

  late int _highScore;
  int get highScore => _highScore;

  PlayerData({
    int highScore = 0,
  }) {
    _highScore = highScore;
  }
}
