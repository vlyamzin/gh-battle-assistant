enum UnitType {
  banditGuard
}


class Unit {
  late final int number;
  final UnitType type;
  final String displayName;
  final int healthPoint;
  final int? shield;
  final int? meleeAttack;
  final int? rangeAttack;
  final int? retaliate;

  Unit({
    required number,
    required this.type,
    required this.displayName,
    required this.healthPoint,
    this.shield = 0,
    this.meleeAttack = 0,
    this.rangeAttack = 0,
    this.retaliate = 0
  }) : this.number = 1;


}
