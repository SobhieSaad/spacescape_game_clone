

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:spacescape/game/enemy.dart';

class Bullet extends SpriteComponent with Hitbox,Collidable {

  double _speed=450;
  Vector2 direction=Vector2(0, -1);
  
  Bullet({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(
    size: size,
    sprite: sprite,
    position: position,
  );

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    final shape=HitboxCircle(definition: 0.4);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if(other is Enemy){
      this.remove();
    }
  }
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    this.position+=direction * this._speed * dt;

    if(this.position.y<0){
      remove();
    }
  }
}