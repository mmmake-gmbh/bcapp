import 'package:bildungscampus_app/game/overlays/game_over_menu.dart';
import 'package:bildungscampus_app/game/overlays/pause_button.dart';
import 'package:bildungscampus_app/game/overlays/pause_menu.dart';
import 'package:bildungscampus_app/game/space_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

// Creating this as a file private object so as to
// avoid unwanted rebuilds of the whole game object.
final _spacescapeGame = SpaceGame();

// This class represents the actual game screen
// where all the action happens.
class StartGame extends StatelessWidget {
  const StartGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // WillPopScope provides us a way to decide if
      // this widget should be poped or not when user
      // presses the back button.
      body: WillPopScope(
        onWillPop: () async => false,
        // GameWidget is useful to inject the underlying
        // widget of any class extending from Flame's Game class.
        child: GameWidget(
          game: _spacescapeGame,
          // Initially only pause button overlay will be visible.
          initialActiveOverlays: const [PauseButton.id],
          overlayBuilderMap: {
            PauseButton.id: (BuildContext context, SpaceGame game) =>
                PauseButton(
                  game: game,
                ),
            PauseMenu.id: (BuildContext context, SpaceGame game) => PauseMenu(
                  game: game,
                ),
            GameOverMenu.id: (BuildContext context, SpaceGame game) =>
                GameOverMenu(
                  game: game,
                ),
          },
        ),
      ),
    );
  }
}
