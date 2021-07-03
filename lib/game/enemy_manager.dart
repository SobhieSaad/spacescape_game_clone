
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:spacescape/game/enemy.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/game/knows_game_size.dart';

class EnemyManager extends BaseComponent with KnowsGameSize,HasGameRef<SpacescapeGame>{

  late Timer timer;
  SpriteSheet spriteSheet;
  late Timer _freezeTimer;
  Random random=Random();
  EnemyManager({required this.spriteSheet}): super(){
    timer=Timer(1,callback: _spawnEnemy,repeat: true);
    _freezeTimer=Timer(2, callback: (){
      timer.start();
    });
  }

  void _spawnEnemy(){
    Vector2 initSize=Vector2(64,64);
    Vector2 position=Vector2(random.nextDouble()* gameSize.x, 0);
    
    position.clamp(Vector2.zero()+initSize/2, gameSize-initSize/2);
    Enemy enemy=Enemy(
      sprite:  spriteSheet.getSpriteById(12),
      size: initSize,
      position: position
    );

    enemy.anchor=Anchor.center;

    gameRef.add(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
    _freezeTimer.update(dt);
  }

  void reset() {
    timer.stop();
    timer.start();
  }

  void freeze() {

    timer.stop();
    _freezeTimer.stop();
    _freezeTimer.start();

  }
}