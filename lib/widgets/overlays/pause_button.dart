
import 'package:flutter/material.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/widgets/overlays/pause_menu.dart';

class PauseButton extends StatelessWidget {
  static const String ID='PauseButton';
  final SpacescapeGame gameRef;

  const PauseButton({Key? key,required this.gameRef}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter ,
      child: TextButton(
        child: Icon(
          Icons.pause_rounded,
          color: Colors.white,
        ),
        onPressed: (){
          gameRef.pauseEngine();
          gameRef.overlays.add(PauseMenu.ID);
          gameRef.overlays.remove(PauseButton.ID);
        },
      ),
    );
  }
}
