import 'package:flame/components.dart';
import 'package:space_shooter/components/bullet.dart';
import 'package:space_shooter/space_shooter.dart';
class Player extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
late final SpawnComponent _bulletSpawner;

  Player() : super(
    size: Vector2(100, 150),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(32, 48),
      ),
    );

    position = game.size / 2;

    _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position +
              Vector2(
                0,
                -height / 2,
              ),
        );

        // return bullet;
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);
  }

  // Other methods omitted
  void move(Vector2 delta){
    position.add(delta);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }
}