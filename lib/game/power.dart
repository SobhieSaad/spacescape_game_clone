import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:spacescape/game/command.dart';
import 'package:spacescape/game/enemy.dart';
import 'package:spacescape/game/enemy_manager.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/game/player.dart';

abstract class PowerUp extends SpriteComponent
    with HasGameRef<SpacescapeGame>, Hitbox, Collidable {

  late Timer _timer;
  Sprite getSprite();

  void onActivated();

  PowerUp({
    Vector2? position,
    Vector2? size,
    Sprite? sprite,
  }) : super(
          position: position,
          size: size,
          sprite: sprite,
        ){
    _timer=Timer(3,callback: this.remove);

  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    _timer.update(dt);
  }

  @override
  void onMount() {
    final shape= HitboxCircle(definition: 0.5);
    addShape(shape);
    // TODO: implement onMount
    this.sprite= getSprite();
    super.onMount();
    _timer.start();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if(other is Player){
      onActivated();
      remove();
    }
    super.onCollision(intersectionPoints, other);
  }
}

class Nuke extends PowerUp{

  Nuke({
    Vector2? position, Vector2? size
}) : super(position: position,size: size);

  
  @override
  Sprite getSprite() {
    return Sprite(gameRef.images.fromCache('nuke.png'));


  }

  @override
  void onActivated() {
    final command=Command<Enemy>(action: (enemy){
      enemy.destroy();
    });

    gameRef.addCommand(command);

  }

}


class Health extends PowerUp{
  Health({
    Vector2? position, Vector2? size
  }) : super(position: position,size: size);

  @override
  Sprite getSprite() {
    return Sprite(gameRef.images.fromCache('icon_plusSmall.png'));


  }
  @override
  void onActivated() {
    final command=Command<Player>(action: (player){
     player.increaseHealth(10);
    });

    gameRef.addCommand(command);
  }
}

class Freeze extends PowerUp{
  Freeze({
    Vector2? position, Vector2? size
  }) : super(position: position,size: size);

  @override
  Sprite getSprite() {
    return Sprite(gameRef.images.fromCache('freeze.png'));


  }
  @override
  void onActivated() {
    final command=Command<Enemy>(action: (enemy){
      enemy.freeze();
    });

    gameRef.addCommand(command);

    final command2=Command<EnemyManager>(action: (enemyManager){
      enemyManager.freeze();
    });

    gameRef.addCommand(command2);
  }
}

class MultiFire extends PowerUp{
  MultiFire({
    Vector2? position, Vector2? size
  }) : super(position: position,size: size);

  @override
  Sprite getSprite() {
    return Sprite(gameRef.images.fromCache('multi_fire.png'));


  }
  @override
  void onActivated() {
    final command=Command<Player>(action: (player){
      player.shootMultipleBullet();
    });

    gameRef.addCommand(command);
  }
}
