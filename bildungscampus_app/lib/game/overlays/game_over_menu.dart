import 'package:bildungscampus_app/game/overlays/pause_button.dart';
import 'package:bildungscampus_app/game/space_game.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:flutter/material.dart';

// This class represents the game over menu overlay.
class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final SpaceGame game;

  const GameOverMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pause menu title.
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Game Over',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),

          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(GameOverMenu.id);
                game.overlays.add(PauseButton.id);
                game.reset();
                game.resumeEngine();
              },
              child: const Text('Restart'),
            ),
          ),

          // Exit button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(GameOverMenu.id);
                game.reset();
                game.resumeEngine();

                Navigator.of(context)
                    .pushReplacementNamed(AppRouter.fourtyTwoRoute);
              },
              child: const Text('Exit'),
            ),
          ),
        ],
      ),
    );
  }
}
