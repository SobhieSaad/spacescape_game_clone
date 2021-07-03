
import 'package:flame/components.dart';
import 'package:flame/game.dart';

mixin KnowsGameSize on BaseComponent{
  late Vector2 gameSize;

  void onResize(Vector2 newGameSize){
    gameSize=newGameSize;
  }
}