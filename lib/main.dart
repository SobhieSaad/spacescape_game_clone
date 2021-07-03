import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacescape/game/game.dart';
import 'package:spacescape/models/player_data.dart';
import 'package:spacescape/screens/main_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(ChangeNotifierProvider(
    create: (context) => PlayerData.fromMap(PlayerData.defaultData),
    child: MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme:ThemeData(
        brightness: Brightness.dark,
        fontFamily: "BungeeInline",
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MainMenu(),
    ),
  ));
}
