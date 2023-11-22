import 'package:bildungscampus_app/game/enemy.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

// This component represent a bullet in game world.
class Bullet extends SpriteComponent with CollisionCallbacks {
  // Speed of the bullet.
  final double _speed = 450;

  // Controls the direction in which bullet travels.
  Vector2 direction = Vector2(0, -1);

  Bullet({
    required super.sprite,
    required super.position,
    required super.size,
  });

  @override
  void onMount() {
    super.onMount();

    // Adding a circular hitbox with radius as 0.4 times
    //  the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.4,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // If the other Collidable is Enemy, remove this bullet.
    if (other is Enemy) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Moves the bullet to a new position with _speed and direction.
    position += direction * _speed * dt;

    // If bullet crosses the upper boundary of screen
    // mark it to be removed it from the game world.
    if (position.y < 0) {
      removeFromParent();
    }
  }
}
