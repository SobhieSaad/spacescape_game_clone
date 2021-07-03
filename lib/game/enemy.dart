import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:spacescape/game/bullet.dart';
import 'package:spacescape/game/command.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/game/knows_game_size.dart';
import 'package:spacescape/game/player.dart';

class Enemy extends SpriteComponent
    with KnowsGameSize, Hitbox, Collidable, HasGameRef<SpacescapeGame> {
  double _speed = 250;
  late Timer _freezeTimer;
  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(
    size: size,
    sprite: sprite,
    position: position,
  ) {
    angle = pi;
    _freezeTimer=Timer(2,callback: (){
      _speed=250;
    });
  }

  Random _random = Random();

  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2.random(_random)) * 500;
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    final shape = HitboxCircle(definition: 0.8);
    addShape(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Bullet || other is Player) {
      destroy();
    }
  }

  void destroy(){
    this.remove();

    final command=Command<Player>(action: (player) {
      player.addToScore(1);
    });

    gameRef.addCommand(command);

    final particalComponenet = ParticleComponent(
        particle: Particle.generate(
          count: 20,
          lifespan: 0.1,
          generator: (i) =>
              AcceleratedParticle(
                acceleration: getRandomVector(),
                speed: getRandomVector(),
                position: this.position.clone(),
                child: CircleParticle(
                  paint: Paint()
                    ..color = Colors.white,
                  radius: 2,
                ),
              ),
        ));

    gameRef.add(particalComponenet);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _freezeTimer.update(dt);
    this.position += Vector2(0, 1) * _speed * dt;

    if (this.position.y > this.gameSize.y) {
      remove();
    }
  }

  void freeze() {
    _speed=0;
    _freezeTimer.stop();
    _freezeTimer.start();

  }



}
