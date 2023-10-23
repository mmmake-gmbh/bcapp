import 'dart:async';

import 'package:bildungscampus_app/game/bullet.dart';
import 'package:bildungscampus_app/game/command.dart';
import 'package:bildungscampus_app/game/enemy.dart';
import 'package:bildungscampus_app/game/enemy_manager.dart';
import 'package:bildungscampus_app/game/health_bar.dart';
import 'package:bildungscampus_app/game/overlays/game_over_menu.dart';
import 'package:bildungscampus_app/game/overlays/pause_button.dart';
import 'package:bildungscampus_app/game/overlays/pause_menu.dart';
import 'package:bildungscampus_app/game/player.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class SpaceGame extends FlameGame with HasCollisionDetection {
  final World world = World();

  late CameraComponent primaryCamera;

  // Stores a reference to player component.
  late Player _player;

  // Stores a reference to the main spritesheet.
  late SpriteSheet spriteSheet;

  // Stores a reference to an enemy manager component.
  late EnemyManager _enemyManager;

  // Displays player score on top left.
  late TextComponent _playerScore;

  // Displays player helth on top right.
  late TextComponent _playerHealth;

  // List of commands to be processed in current update.
  final _commandList = List<Command>.empty(growable: true);

  // List of commands to be processed in next update.
  final _addLaterCommandList = List<Command>.empty(growable: true);

  // Indicates wheater the game world has been already initilized.
  bool _isAlreadyLoaded = false;

  // Returns the size of the playable area of the game window.
  Vector2 fixedResolution = Vector2(540, 960);
  @override
  FutureOr<void> onLoad() async {
    if (!_isAlreadyLoaded) {
      // Loads and caches all the images for later use.
      await images.loadAll([
        'game/simpleSpace_tilesheet.png',
      ]);

      spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: images.fromCache('game/simpleSpace_tilesheet.png'),
        columns: 8,
        rows: 6,
      );

      await add(world);

      // Create a basic joystick component on left.
      final joystick = JoystickComponent(
        anchor: Anchor.bottomLeft,
        position: Vector2(30, fixedResolution.y - 30),
        // size: 100,
        background: CircleComponent(
          radius: 60,
          paint: Paint()..color = Colors.red.withOpacity(0.5),
        ),
        knob: CircleComponent(radius: 60),
      );

      final stars = await ParallaxComponent.load(
        [
          ParallaxImageData('game/stars1.png'),
          ParallaxImageData('game/stars2.png')
        ],
        repeat: ImageRepeat.repeat,
        baseVelocity: Vector2(0, -50),
        velocityMultiplierDelta: Vector2(0, 1.5),
        size: fixedResolution,
      );

      primaryCamera = CameraComponent.withFixedResolution(
        world: world,
        width: fixedResolution.x,
        height: fixedResolution.y,
        //hudComponents: [joystick], //TODO: Check why this is not working
      )..viewfinder.position = fixedResolution / 2;
      await add(primaryCamera);

      _player = Player(
        joystick: joystick,
        sprite: spriteSheet.getSpriteById(16), //16 index of the tilesheet
        size: Vector2(64, 64),
        position: fixedResolution / 2,
      );

      // Makes sure that the sprite is centered.
      _player.anchor = Anchor.center;

      _enemyManager = EnemyManager(spriteSheet: spriteSheet);

      // Create a fire button component on right
      final button = ButtonComponent(
        button: CircleComponent(
          radius: 60,
          paint: Paint()..color = Colors.white.withOpacity(0.5),
        ),
        anchor: Anchor.bottomRight,
        position: Vector2(fixedResolution.x - 30, fixedResolution.y - 30),
        onPressed: _player.joystickAction,
      );

      // Create text component for player score.
      _playerScore = TextComponent(
        text: 'Score: 0',
        position: Vector2(10, 10),
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'BungeeInline',
          ),
        ),
        anchor: Anchor.topLeft,
      );

      // Create text component for player health.
      _playerHealth = TextComponent(
        text: 'Health: 100%',
        position: Vector2(fixedResolution.x - 10, 10),
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'BungeeInline',
          ),
        ),
        anchor: Anchor.topRight,
      );

      final healthPosition = _playerHealth.positionOfAnchor(Anchor.topLeft);

      // Add the blue bar indicating health.
      final healthBar = HealthBar(
        player: _player,
        position: Vector2(healthPosition.x - 10,
            healthPosition.y - 8), //small adjusting to the screen position
        priority: -1,
        anchor: Anchor.topLeft,
      );

      // Makes the game use a fixed resolution irrespective of the windows size.
      await world.addAll([
        joystick,
        stars,
        _player,
        _enemyManager,
        button,
        _playerScore,
        _playerHealth,
        healthBar,
      ]);

      // Set this to true so that we do not initilize
      // everything again in the same session.
      _isAlreadyLoaded = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Run each command from _commandList on each
    // component from components list. The run()
    // method of Command is no-op if the command is
    // not valid for given component.
    for (var command in _commandList) {
      for (var component in world.children) {
        command.run(component);
      }
    }

    // Remove all the commands that are processed and
    // add all new commands to be processed in next update.
    _commandList.clear();
    _commandList.addAll(_addLaterCommandList);
    _addLaterCommandList.clear();

    if (_player.isMounted) {
      // Update score and health components with latest values.
      _playerScore.text = 'Score: ${_player.score}';
      _playerHealth.text = 'Health: ${_player.health}%';

      /// Display [GameOverMenu] when [Player.health] becomes
      /// zero and camera stops shaking.
      // if (_player.health <= 0 && (!camera.shaking)) {
      if (_player.health <= 0) {
        pauseEngine();
        overlays.remove(PauseButton.id);
        overlays.add(GameOverMenu.id);
      }
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (_player.health > 0) {
          pauseEngine();
          overlays.remove(PauseButton.id);
          overlays.add(PauseMenu.id);
        }
        break;
    }

    super.lifecycleStateChange(state);
  }

  // Adds given command to command list.
  void addCommand(Command command) {
    _addLaterCommandList.add(command);
  }

  // Resets the game to inital state. Should be called
  // while restarting and exiting the game.
  void reset() {
    // First reset player, enemy manager.
    _player.reset();
    _enemyManager.reset();

    // Now remove all the enemies and bullets
    // from the game world. Note that, we are not calling
    // Enemy.destroy() because it will unnecessarily
    // run explosion effect and increase players score.
    world.children.whereType<Enemy>().forEach((enemy) {
      enemy.removeFromParent();
    });

    world.children.whereType<Bullet>().forEach((bullet) {
      bullet.removeFromParent();
    });
  }
}
