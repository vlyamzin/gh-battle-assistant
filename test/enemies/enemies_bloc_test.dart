// import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:gh_battle_assistant/back/unit_raw_data.dart';
import 'package:gh_battle_assistant/common/enums/activity_type.dart';
import 'package:gh_battle_assistant/common/enums/unit_type.dart';
import 'package:gh_battle_assistant/screens/stats/model/unit.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/model/settings.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/repository/settings_repository.dart';
import 'package:gh_battle_assistant/services/logger_service.dart';
import 'package:gh_battle_assistant/services/util_service.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/hydrated_bloc.dart';
import 'enemies_mock_data.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

class MockLoggerService extends Mock implements LoggerService {}

class MockUtilService extends Mock implements UtilService {}

class MockEnemiesRepository extends Mock implements EnemiesRepository {}

void main() {
  group('EnemiesBloc', () {
    late SettingsRepository settingsRepository;
    late UtilService utilService;
    late LoggerService loggerService;
    late EnemiesRepository enemiesRepository;
    late UnitRawData rawData;
    late GetIt di;

    setUpAll(() {
      // mockHydratedStorage(() {});
      registerFallbackValue(UnitType.aestherAshblade);
      di = GetIt.instance;
      settingsRepository = MockSettingsRepository();
      utilService = MockUtilService();
      loggerService = MockLoggerService();
      di.registerSingleton<SettingsRepository>(settingsRepository);
      di.registerSingleton<UtilService>(utilService);
      di.registerSingleton<LoggerService>(loggerService);
    });

    setUp(() {
      rawData = unitRawData;
      enemiesRepository = MockEnemiesRepository();
      when(() => enemiesRepository.byId(any<UnitType>())).thenReturn(rawData);
      when(() => utilService.randomize(any())).thenReturn(0);
      when(() => loggerService.log(any())).thenReturn('');
      when(() => settingsRepository.loadSettings())
          .thenReturn(Settings(difficulty: 1, newGame: true));
    });

    test('initial state is correct', () {
      mockHydratedStorage(() {
        final bloc = EnemiesBloc(enemiesRepository);
        expect(bloc.state, EnemiesState.initial());
      });
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        mockHydratedStorage(() {
          final bloc = EnemiesBloc(enemiesRepository);
          expect(bloc.fromJson(bloc.toJson(bloc.state)!), bloc.state);
        });
      });
    });

    group('stack added', () {
      final newStack = enemies.monsters[0];
      final newStackWithUnit = UnitStack(
        type: newStack.type,
        displayName: newStack.displayName,
        maxNumber: newStack.maxNumber,
        units: [unit],
      );
      final newStack2 = newStack.copyWith(
        type: UnitType.ancientArtillery,
        displayName: 'Test unit 2',
      );

      blocTest<EnemiesBloc, EnemiesState>(
        'to the empty state',
        build: () => mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
        act: (bloc) => bloc.add(StackAddedE(newStack)),
        expect: () => [
          EnemiesState.loaded(Enemies(monsters: [newStack])),
        ],
      );

      blocTest<EnemiesBloc, EnemiesState>(
        'to the existing state as a new one',
        build: () => mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
        seed: () => EnemiesState.loaded(Enemies(monsters: [newStack])),
        act: (bloc) => bloc.add(StackAddedE(newStack2)),
        expect: () => [
          EnemiesState.loaded(Enemies(monsters: [newStack, newStack2])),
        ],
      );

      blocTest<EnemiesBloc, EnemiesState>(
        'to the existing stack with new units',
        build: () => mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
        seed: () => EnemiesState.loaded(Enemies(monsters: [newStack])),
        act: (bloc) {
          final updatedStack = newStack.copyWith(units: [
            newStackWithUnit.units[0],
            Unit(number: 2, displayName: 'Unit 2', healthPoint: 10)
          ]);
          return bloc.add(StackAddedE(updatedStack));
        },
        expect: () => [
          EnemiesState.loaded(
            Enemies(
              monsters: [
                newStack.copyWith(units: [
                  newStackWithUnit.units[0],
                  Unit(number: 2, displayName: 'Unit 2', healthPoint: 10)
                ]),
              ],
            ),
          )
        ],
      );

      blocTest<EnemiesBloc, EnemiesState>('in the middle of the game',
          setUp: () {
            when(() => settingsRepository.loadSettings())
                .thenReturn(Settings(difficulty: 1, newGame: false));
          },
          build: () =>
              mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
          seed: () => EnemiesState.loaded(Enemies(monsters: [newStack])),
          act: (bloc) => bloc.add(StackAddedE(newStack2)),
          expect: () => [
                isA<EnemiesLoaded>().having(
                  (state) => state.enemies,
                  'enemies',
                  isA<Enemies>().having(
                    (model) => model.monsters
                        .firstWhere((e) => e.type == newStack2.type),
                    'monsters',
                    isA<UnitStack>().having(
                      (stack) => stack.actions,
                      'actions',
                      isA<UnitActionList>().having(
                          (actions) => actions.currentAction,
                          'currentAction',
                          isNotNull),
                    ),
                  ),
                )
              ]);
    });

    group('stack removed', () {
      final stack = enemies.monsters[0];

      blocTest<EnemiesBloc, EnemiesState>('from the existing state',
          build: () =>
              mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
          seed: () => EnemiesState.loaded(enemies),
          act: (bloc) => bloc.add(StackRemovedE(stack)),
          expect: () => [EnemiesState.loaded(Enemies(monsters: []))]);
    });

    group('clear enemies', () {
      blocTest<EnemiesBloc, EnemiesState>(
        'and start new game',
        build: () => mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
        seed: () => EnemiesState.loaded(enemies),
        act: (bloc) => bloc.add(ClearEnemiesList()),
        expect: () => [
          EnemiesState.initial(),
        ],
      );
    });

    group('draw new action', () {
      blocTest<EnemiesBloc, EnemiesState>(
        'and init actions list if new game started',
        build: () => mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
        seed: () => EnemiesState.loaded(enemies),
        act: (bloc) => bloc.add(NewActionRequested()),
        wait: Duration(milliseconds: 0),
        expect: () => [
          isA<EnemiesLoaded>().having(
            (state) => state.enemies.monsters[0],
            'stack',
            isA<UnitStack>()
                .having(
                  (stack) => stack.actions.currentAction,
                  'currentAction',
                  isNotNull,
                )
                .having((stack) => stack.actions.availableActionIndexes!.length,
                    'availableActionIndexes length', 1),
          )
        ],
      );

      group('for running game ', () {
        final action1 = actions[0];
        final action2 =
            action1.copyWith(id: 2, initiative: 2, shouldRefresh: false);

        final unitUpdateMock = UnitUpdateTest();

        setUp(() {
          when(() => settingsRepository.loadSettings())
              .thenReturn(Settings(difficulty: 1, newGame: false));
        });

        // TODO add test
        blocTest(
          'and sort stacks by its initiative in this round',
          build: () =>
              mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
          expect: () => [],
        );

        blocTest<EnemiesBloc, EnemiesState>(
          'and refresh available actions list if currentActions has shouldRefresh:true',
          setUp: () {
            when(() => utilService.randomize(any())).thenReturn(0);
          },
          build: () =>
              mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
          seed: () {
            final stack = UnitStack(
                displayName: '',
                units: [unit],
                type: UnitType.ancientArtillery,
                actions: UnitActionList(
                  currentAction: action1,
                  allActions: [action1, action2],
                  availableActionIndexes: [1],
                ));
            return EnemiesState.loaded(Enemies(monsters: [stack]));
          },
          act: (bloc) => bloc.add(NewActionRequested()),
          expect: () => [
            isA<EnemiesLoaded>().having(
                (state) => state
                    .enemies.monsters[0].actions.availableActionIndexes!.length,
                'availableActionIndexes length',
                1),
          ],
        );

        blocTest<EnemiesBloc, EnemiesState>(
          'and update unit stats',
          build: () =>
              mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
          seed: () {
            return EnemiesState.loaded(
                Enemies(monsters: [unitUpdateMock.stack]));
          },
          act: (bloc) => bloc.add(NewActionRequested()),
          expect: () {
            return [
              EnemiesState.loaded(Enemies(monsters: [unitUpdateMock.stack])),
              isA<EnemiesLoaded>().having(
                (state) {
                  print(state);
                  return state.enemies.monsters[0].units[0];
                },
                'unit',
                isA<Unit>()
                    .having(
                      (unit) => unit.healthPoint,
                      'unit.healthPoint',
                      9,
                    )
                    .having((unit) => unit.shield, 'shield', 1)
                    .having((unit) => unit.attack, 'attack', 3)
                    .having((unit) => unit.range, 'range', 1)
                    .having((unit) => unit.move, 'move', 4)
                    .having((unit) => unit.retaliate, 'retaliate', 1)
                    .having((unit) => unit.pierced, 'pierced', 0)
                    .having((unit) => unit.suffer, 'suffer', 3)
                    .having((unit) => unit.heal, 'heal', 3)
                    .having((unit) => unit.negativeEffects, 'negativeEffects',
                        isEmpty),
              )
            ];
          },
        );

        blocTest<EnemiesBloc, EnemiesState>(
          'and cannot be healed if poisoned',
          build: () =>
              mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
          seed: () {
            final mock = UnitUpdateTest();
            mock.stack.units[0].negativeEffects.add(ActivityType.poison);
            return EnemiesState.loaded(Enemies(monsters: [mock.stack]));
          },
          act: (bloc) => bloc.add(NewActionRequested()),
          expect: () => [
            isA<EnemiesLoaded>().having(
              (state) => state.enemies.monsters[0].units[0].healthPoint,
              'healthPoint',
              8,
            )
          ],
        );

        blocTest<EnemiesBloc, EnemiesState>(
          'and cannot overheal',
          build: () =>
              mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
          seed: () {
            final mock = UnitUpdateTest();
            mock.stack.units[0] = mock.stack.units[0].copyWith(heal: 40);
            return EnemiesState.loaded(Enemies(monsters: [mock.stack]));
          },
          act: (bloc) => bloc.add(NewActionRequested()),
          expect: () => [
            isA<EnemiesLoaded>().having(
              (state) => state.enemies.monsters[0].units[0].healthPoint,
              'healthPoint',
              10,
            )
          ],
        );
        blocTest<EnemiesBloc, EnemiesState>(
          'and does not have attack, move and range values',
          build: () =>
              mockHydratedStorage(() => EnemiesBloc(enemiesRepository)),
          seed: () {
            final mock = UnitUpdateTest();
            final stack = mock.stack.copyWith(
              actions: UnitActionList(
                currentAction: mock.action,
                allActions: [
                  mock.action,
                  UnitAction(
                    id: 5,
                    initiative: 5,
                    shouldRefresh: true,
                    modifiers: {},
                  ),
                ],
                availableActionIndexes: [1],
              ),
            );
            return EnemiesState.loaded(Enemies(monsters: [stack]));
          },
          act: (bloc) => bloc.add(NewActionRequested()),
          expect: () => <Matcher>[
            isA<EnemiesLoaded>().having(
              (state) => state.enemies.monsters[0].units[0],
              'unit',
              isA<Unit>()
                  .having((unit) => unit.attack, 'attack', 0)
                  .having((unit) => unit.range, 'range', 0)
                  .having((unit) => unit.move, 'move', 0),
            ),
          ],
        );
      });
    });
  });
}
