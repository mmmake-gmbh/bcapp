import 'dart:math';

import 'package:bildungscampus_app/game/enemy.dart';
import 'package:bildungscampus_app/game/models/player_data.dart';
import 'package:bildungscampus_app/game/space_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/experimental.dart';
import 'package:flame/particles.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bullet.dart';

// This component class represents the player character in game.
class Player extends SpriteComponent
    with CollisionCallbacks, HasGameReference<SpaceGame> {
  // Player joystick
  JoystickComponent joystick;

  // Player health.
  int _health = 100;
  int get health => _health;

  // Details of current spaceship.
  //Spaceship _spaceship;
  final double spaceshipSpeed = 400;

  // A reference to PlayerData so that
  // we can modify money.
  late PlayerData _playerData;
  int get score => _playerData.currentScore;

  // If true, player will shoot 3 bullets at a time.
  bool _shootMultipleBullets = false;

  // Holds an object of Random class to generate random numbers.
  final _random = Random();

  // This method generates a random vector such that
  // its x component lies between [-100 to 100] and
  // y component lies between [200, 400]
  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2(0.5, -1)) * 200;
  }

  Player({
    required this.joystick,
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void onMount() {
    super.onMount();

    // Adding a circular hitbox with radius as 0.8 times
    // the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);

    _playerData = game.buildContext!.read<PlayerData>();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // If other entity is an Enemy, reduce player's health by 10.
    if (other is Enemy) {
      // Make the camera shake, with custom intensity.
      // TODO: Investigate how camera shake should be implemented in new camera system.
      // game.primaryCamera.viewfinder.add(
      //   MoveByEffect(
      //     Vector2.all(10),
      //     PerlinNoiseEffectController(duration: 1),
      //   ),
      // );

      _health -= 10;
      if (_health <= 0) {
        _health = 0;
      }
    }
  }

  // This method is called by game class for every frame.
  @override
  void update(double dt) {
    super.update(dt);

    // Increment the current position of player by (speed * delta time) along moveDirection.
    // Delta time is the time elapsed since last update. For devices with higher frame rates, delta time
    // will be smaller and for devices with lower frame rates, it will be larger. Multiplying speed with
    // delta time ensure that player speed remains same irrespective of the device FPS.
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * spaceshipSpeed * dt);
    }

    // Clamp position of player such that the player sprite does not go outside the screen size.
    position.clamp(
      Vector2.zero() + size / 2,
      game.fixedResolution - size / 2,
    );

    // Adds thruster particles.
    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: (position.clone() + Vector2(0, size.y / 3)),
          child: CircleParticle(
            radius: 1,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );

    game.world.add(particleComponent);
  }

  void joystickAction() {
    final bullet = Bullet(
      sprite: game.spriteSheet.getSpriteById(28),
      size: Vector2(64, 64),
      position: position.clone(),
    );

    // Anchor it to center and add to game world.
    bullet.anchor = Anchor.center;
    game.world.add(bullet);

    // If multiple bullet is on, add two more
    // bullets rotated +-PI/6 radians to first bullet.
    if (_shootMultipleBullets) {
      for (int i = -1; i < 2; i += 2) {
        Bullet bullet = Bullet(
          sprite: game.spriteSheet.getSpriteById(28),
          size: Vector2(64, 64),
          position: position.clone(),
        );

        // Anchor it to center and add to game world.
        bullet.anchor = Anchor.center;
        bullet.direction.rotate(i * pi / 6);
        game.world.add(bullet);
      }
    }
  }

  // Adds given points to player score
  /// and also add it to [PlayerData.money].
  void addToScore(int points) {
    _playerData.currentScore += points;
  }

  // Increases health by give amount.
  void increaseHealthBy(int points) {
    _health += points;
    // Clamps health to 100.
    if (_health > 100) {
      _health = 100;
    }
  }

  // Resets player score, health and position. Should be called
  // while restarting and exiting the game.
  void reset() {
    _playerData.currentScore = 0;
    _health = 100;
    position = game.fixedResolution / 2;
  }

  // Allows player to first multiple bullets for 4 seconds when called.
  void shootMultipleBullets() {
    _shootMultipleBullets = true;
  }
}
