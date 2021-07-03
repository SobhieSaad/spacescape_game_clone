
import 'package:flutter/material.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/screens/main_menu.dart';
import 'package:spacescape/widgets/overlays/pause_button.dart';
class  PauseMenu extends StatelessWidget {

  static const String ID='PauseMenu';
  final SpacescapeGame gameRef;

  const PauseMenu({Key? key,required this.gameRef}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              "Paused",
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.resumeEngine();
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.overlays.add(PauseButton.ID);
              },
              child: Text("Resume"),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.overlays.add(PauseButton.ID);
                gameRef.reset();
                gameRef.resumeEngine();
              },
              child: Text("Restart"),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.reset();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>  MainMenu(),
                ));
              },
              child: Text("Exit"),
            ),
          ),
        ],
      ),
    );
  }
}
