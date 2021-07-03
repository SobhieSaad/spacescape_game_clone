import 'package:flutter/material.dart';

import 'spaceship_details.dart';

// This class represents all the persistent data that we
// might want to store for tracking player progress.
class PlayerData extends ChangeNotifier {
  // The spaceship type of player's current spaceship.
  SpaceShipType spaceshipType;

  // List of all the spaceships owned by player.
  // Note that just storing their type is enough.
  final List<SpaceShipType> ownedSpaceships;

  // Highest player score so far.
  final int highScore;

  // Balance money.
  int money;

  PlayerData({
    required this.spaceshipType,
    required this.ownedSpaceships,
    required this.highScore,
    required this.money,
  });

  /// Creates a new instace of [PlayerData] from given map.
  PlayerData.fromMap(Map<String, dynamic> map)
      : this.spaceshipType = map['currentSpaceshipType'],
        this.ownedSpaceships = map['ownedSpaceshipTypes']
            .map((e) => e as SpaceShipType) // Map out each element.
            .cast<SpaceShipType>() // Cast each element to SpaceshipType.
            .toList(), // Convert to a List<SpaceshipType>.
        this.highScore = map['highScore'],
        this.money = map['money'];

  // A default map which should be used for creating the
  // very first PlayerData instance when game is launched
  // for the first time.
  static Map<String, dynamic> defaultData = {
    'currentSpaceshipType': SpaceShipType.Canary,
    'ownedSpaceshipTypes': [SpaceShipType.Canary],
    'highScore': 0,
    'money': 0,
  };

  /// Returns true if given [SpaceshipType] is owned by player.
  bool isOwned(SpaceShipType spaceshipType) {
    return this.ownedSpaceships.contains(spaceshipType);
  }

  /// Returns true if player has enough money to by given [SpaceshipType].
  bool canBuy(SpaceShipType spaceshipType) {
    return (this.money >= SpaceShip.getSpaceShipByType(spaceshipType).cost);
  }

  /// Returns true if player's current spaceship type is same as given [SpaceshipType].
  bool isEquipped(SpaceShipType spaceshipType) {
    return (this.spaceshipType == spaceshipType);
  }

  /// Buys the given [SpaceshipType] if player has enough money and does not already own it.
  void buy(SpaceShipType spaceshipType) {
    if (canBuy(spaceshipType) && (!isOwned(spaceshipType))) {
      this.money -= SpaceShip.getSpaceShipByType(spaceshipType).cost;
      this.ownedSpaceships.add(spaceshipType);
      notifyListeners();
    }
  }

  /// Sets the given [SpaceshipType] as the current spaceship type for player.
  void equip(SpaceShipType spaceshipType) {
    this.spaceshipType = spaceshipType;
    notifyListeners();
  }
}
