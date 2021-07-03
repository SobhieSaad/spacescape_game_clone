import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/particles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacescape/game/command.dart';
import 'package:spacescape/game/enemy.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/game/knows_game_size.dart';
import 'package:spacescape/models/player_data.dart';
import 'package:spacescape/models/spaceship_details.dart';

import 'bullet.dart';

class Player extends SpriteComponent
    with
        KnowsGameSize,
        Hitbox,
        Collidable,
        JoystickListener,
        HasGameRef<SpacescapeGame> {
  Vector2 moveDirection = Vector2.zero();
  double _speed = 300;
  int _score = 0;
  int _health = 100;

  int get score =>_score;
  int get health =>_health;

  SpaceShipType spaceShipType;
  SpaceShip _spaceShip;
  Random _random = Random();
  bool _shootMultipleBullet=false;
  late  Timer _powerUpTimer;
  late PlayerData _playerData;
  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2(0.5, -1)) * 200;
  }

  void increaseHealth(int points){
    _health+=points;

    if(_health>100){
      _health=100;
    }
}

   void shootMultipleBullet(){
     _shootMultipleBullet=true;
     _powerUpTimer.stop();
     _powerUpTimer.start();
   }


  Player({
    required this.spaceShipType,
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  })  : this._spaceShip = SpaceShip.getSpaceShipByType(spaceShipType),
        super(
          size: size,
          sprite: sprite,
          position: position,
        ){
    _powerUpTimer=Timer(4,callback: (){
      _shootMultipleBullet=false;
    });
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    final shape = HitboxCircle(definition: 0.8);
    addShape(shape);
    
    _playerData=Provider.of<PlayerData>(gameRef.buildContext!,listen: false);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      gameRef.camera.shake();
      _health -= 10;
      if (_health <= 0) {
        _health = 0;
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _powerUpTimer.update(dt);

    this.position += moveDirection.normalized() * _spaceShip.speed * dt;

    // Clamp position of player such that the player sprite does not go outside the screen size.
    this.position.clamp(
          Vector2.zero() + this.size / 2,
          gameSize - this.size / 2,
        );

    // Adds thruster particles.
    final particleComponent = ParticleComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: (this.position.clone() + Vector2(0, this.size.y / 3)),
          child: CircleParticle(
            radius: 1,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );

    gameRef.add(particleComponent);
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    moveDirection = newMoveDirection;
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.id == 0 && event.event == ActionEvent.down) {
      Bullet bullet = Bullet(
        sprite: gameRef.spriteSheet.getSpriteById(28),
        size: Vector2(64, 64),
        position: this.position.clone(),
      );

      bullet.anchor = Anchor.center;
      gameRef.add(bullet);

      if(_shootMultipleBullet){
        for(int i=-1; i<2;i+=2) {
          Bullet bullet = Bullet(
            sprite: gameRef.spriteSheet.getSpriteById(28),
            size: Vector2(64, 64),
            position: this.position.clone(),
          );

          bullet.anchor = Anchor.center;
          bullet.direction.rotate(i* pi/6);
          gameRef.add(bullet);
        }
      }
    }
    if (event.id == 1 && event.event == ActionEvent.down) {
    final command= Command<Enemy>(action: (enemy){
      enemy.destroy();
    });

    gameRef.addCommand(command);
    }
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    switch (event.directional) {
      case JoystickMoveDirectional.moveUp:
        // TODO: Handle this case.
        this.setMoveDirection(Vector2(0, -1));
        break;
      case JoystickMoveDirectional.moveUpLeft:
        // TODO: Handle this case.
        this.setMoveDirection(Vector2(-1, -1));

        break;
      case JoystickMoveDirectional.moveUpRight:
        this.setMoveDirection(Vector2(1, -1));
        // TODO: Handle this case.
        break;
      case JoystickMoveDirectional.moveRight:
        // TODO: Handle this case.
        this.setMoveDirection(Vector2(1, 0));
        break;
      case JoystickMoveDirectional.moveDown:
        this.setMoveDirection(Vector2(0, 1));
        // TODO: Handle this case.
        break;
      case JoystickMoveDirectional.moveDownRight:
        // TODO: Handle this case.
        this.setMoveDirection(Vector2(1, 1));
        break;
      case JoystickMoveDirectional.moveDownLeft:
        // TODO: Handle this case.
        this.setMoveDirection(Vector2(-1, 1));
        break;
      case JoystickMoveDirectional.moveLeft:
        // TODO: Handle this case.
        this.setMoveDirection(Vector2(-1, 0));
        break;
      case JoystickMoveDirectional.idle:
        // TODO: Handle this case.
        this.setMoveDirection(Vector2.zero());
        break;
    }
  }

  void addToScore(int points){
    _score+=points;
    _playerData.money+=points;
  }
  void reset() {
    this._health = 100;
    this._score = 0;
    this.position = gameRef.viewport.canvasSize / 2;
  }

  void setSpaceshipType(SpaceShipType spaceShipType){
    this.spaceShipType=spaceShipType;
    this._spaceShip=SpaceShip.getSpaceShipByType(spaceShipType);
    sprite=gameRef.spriteSheet.getSpriteById(_spaceShip.spriteId);

  }
}
