
class Unit {
  int? _number;
  late final String displayName;
  late final int healthPoint;
  late final int? shield;
  late final int? attack;
  late final int? range;
  late final int? move;
  late final int? retaliate;
  late final List? perks;
  late final bool? elite;

  Unit({
    int? number,
    required this.displayName,
    required this.healthPoint,
    this.shield = 0,
    this.attack = 0,
    this.range = 0,
    this.move = 0,
    this.retaliate = 0,
    this.elite = false
  }) {
    if (number != null) this._number = number;
  }

  Unit.fromJson(Map data) {
    if (data['displayName'] == null) throw ArgumentError('No displayName provided in Unit model');
    if (data['healthPoint'] == null) throw ArgumentError('No healthPoint provided in Unit model');

    number = data['number'];
    displayName = data['displayName'];
    healthPoint = data['healthPoint'];
    shield = data['shield'];
    attack = data['meleeAttack'];
    range = data['rangeAttack'];
    retaliate = data['retaliate'];
    elite = data['elite'];
  }

  int? get number => _number;

  set number(int? value) {
    if (_number != null) throw ArgumentError('Number already defined');
    if (value == null) throw ArgumentError('Number cant be null');

    _number = value;
  }

  String toString() => 'Unit$number: $displayName';
}
