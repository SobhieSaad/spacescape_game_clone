class SpaceShip {
  final String name;
  final int cost;
  final double speed;
  final int spriteId;
  final String assetPath;
  final int level;

  const SpaceShip({
    required this.name,
    required this.cost,
    required this.speed,
    required this.spriteId,
    required this.assetPath,
    required this.level,
  });

  static SpaceShip getSpaceShipByType(SpaceShipType SpaceShipType)
  {
    return spaceShips[SpaceShipType]?? spaceShips.entries.first.value;
  }

  static const Map<SpaceShipType, SpaceShip> spaceShips={
    SpaceShipType.Canary: SpaceShip(
      name: 'Canary',
      cost: 0,
      speed: 250,
      spriteId: 0,
      assetPath: 'assets/images/ship_A.png',
      level: 1,
    ),
    SpaceShipType.Dusky: SpaceShip(
      name: 'Dusky',
      cost: 100,
      speed: 400,
      spriteId: 1,
      assetPath: 'assets/images/ship_B.png',
      level: 2,
    ),
    SpaceShipType.Condor: SpaceShip(
      name: 'Condor',
      cost: 200,
      speed: 300,
      spriteId: 2,
      assetPath: 'assets/images/ship_C.png',
      level: 2,
    ),
    SpaceShipType.CXC: SpaceShip(
      name: 'CXC',
      cost: 400,
      speed: 300,
      spriteId: 3,
      assetPath: 'assets/images/ship_D.png',
      level: 3,
    ),
    SpaceShipType.Raptor: SpaceShip(
      name: 'Raptor',
      cost: 550,
      speed: 300,
      spriteId: 4,
      assetPath: 'assets/images/ship_E.png',
      level: 3,
    ),
    SpaceShipType.RaptorX: SpaceShip(
      name: 'Raptor-X',
      cost: 700,
      speed: 350,
      spriteId: 5,
      assetPath: 'assets/images/ship_F.png',
      level: 3,
    ),
    SpaceShipType.Albatross: SpaceShip(
      name: 'Albatross',
      cost: 850,
      speed: 400,
      spriteId: 6,
      assetPath: 'assets/images/ship_G.png',
      level: 4,
    ),
    SpaceShipType.DK809: SpaceShip(
      name: 'DK-809',
      cost: 1000,
      speed: 450,
      spriteId: 7,
      assetPath: 'assets/images/ship_H.png',
      level: 4,
    ),
  };
}


enum SpaceShipType{
  Canary,
  Dusky,
  Condor,
  CXC,
  Raptor,
  RaptorX,
  Albatross,
  DK809,
}