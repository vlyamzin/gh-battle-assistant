import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:gh_battle_assistant/models/enums/modifier_type.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';

Map<String, dynamic> monsterJson = {
  'name': 'Test unit',
  'id': 99999,
  'maxNumber': 6,
  'stats': {
    '1': {
      'normal': {
        'health': 8,
        'shield': 0,
        'move': 3,
        'attack': 2,
        'range': null,
        'retaliate': 0,
        'perks': []
      },
      'elite': {
        'health': 9,
        'shield': 1,
        'move': 3,
        'attack': 3,
        'range': 2,
        'retaliate': 3,
        'perks': ['poison']
      }
    }
  },
  'actions': [
    {
      'id': 1,
      'initiative': 1,
      'shouldRefresh': true,
      'values': [],
      'modifier': {
        'attack': 1,
        'heal': 1,
        'move': 1,
        'range': 1,
        'retaliate': 1,
        'shield': 1,
        'suffer': 1,
      }
    },
    {
      'id': 2,
      'initiative': 2,
      'shouldRefresh': false,
      'values': [],
      'modifier': {
        'attack': 1,
        'heal': 1,
        'move': 1,
        'range': 1,
        'retaliate': 1,
        'shield': 1,
        'suffer': 1,
      }
    }
  ]
};

UnitRawData unitRawData = UnitRawData.fromJson(monsterJson);

Enemies enemies = Enemies(monsters: [
  UnitStack(
    displayName: 'Test unit',
    type: UnitType.aestherAshblade,
    maxNumber: 6,
  ),
]);

Unit unit = Unit(
    number: 1,
    displayName: 'Unit 1',
    healthPoint: 10,
    shield: 0,
    attack: 1,
    move: 1,
    range: 1,
    heal: 0,
    retaliate: 0,
    suffer: 0,
    pierced: 0,
    area: [],
    immune: [],
    perks: [],
    elite: false);

List<UnitAction> actions = [
  UnitAction(id: 1, initiative: 1, shouldRefresh: true, modifiers: {
    ModifierType.attack: 1,
    ModifierType.heal: 1,
    ModifierType.move: 1,
    ModifierType.range: 1,
    ModifierType.retaliate: 1,
    ModifierType.shield: 1,
    ModifierType.suffer: 1
  }),
];

class UnitUpdateTest {
  late final UnitAction action;
  late final UnitAction nextAction;
  late final Unit unit;
  late final UnitStack stack;

  UnitUpdateTest() {
    action = UnitAction(
      id: 3,
      initiative: 3,
      shouldRefresh: false,
      modifiers: {},
    );
    nextAction =
        UnitAction(id: 4, initiative: 4, shouldRefresh: true, modifiers: {
      ModifierType.attack: 1,
      ModifierType.move: 1,
      ModifierType.range: 1,
      ModifierType.retaliate: 1,
      ModifierType.shield: 1,
      ModifierType.suffer: 3,
      ModifierType.heal: 3,
    });
    unit = Unit(
      number: 1,
      displayName: '',
      healthPoint: 10,
      pierced: 3,
      suffer: 2,
      heal: 1,
      negativeEffects: {
        ActivityType.disarm,
        ActivityType.immobilize,
        ActivityType.invisible,
        ActivityType.muddle,
        ActivityType.pierce,
        ActivityType.strengthen,
        ActivityType.stun,
      },
    );
    stack = UnitStack(
        displayName: '',
        type: UnitType.ancientArtillery,
        units: [unit],
        actions: UnitActionList(
          allActions: [action, nextAction],
          availableActionIndexes: [1],
          currentAction: action,
        ));
  }
}
