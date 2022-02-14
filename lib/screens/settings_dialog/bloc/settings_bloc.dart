import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings_dialog.dart';

part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const DIFFICULTY = 'difficulty';
  static const NEW_GAME = 'new_game';

  final _systemPref = SharedPreferences.getInstance();
  final SettingsRepository _settingsRepository;

  SettingsBloc(this._settingsRepository) : super(SettingsState.initial()) {
    on<SettingsLoadE>(_onSettingsLoad);
    on<SettingsSaveE>((_, emit) async {
      state.maybeMap(
        updated: (SettingsUpdated state) async {
          var snapshot = await _systemPref;

          snapshot.setInt(SettingsBloc.DIFFICULTY, state.settings.difficulty);
          emit(SettingsState.saved());
          emit(SettingsState.updated(state.settings));
        },
        newGame: (NewGame state) {
          emit(SettingsState.saved());
          emit(SettingsState.updated(state.settings));
        },
        orElse: () {},
      );
    });
    on<SettingsDifficultyIncreaseE>(
        (event, emit) => _onChangeDifficulty(emit, 1));
    on<SettingsDifficultyDecreaseE>(
        (event, emit) => _onChangeDifficulty(emit, -1));
    on<StartNewGame>(_onNewGame);
  }

  void _onSettingsLoad(SettingsLoadE event, Emitter<SettingsState> emit) async {
    var prefSnapshot = await _systemPref;
    var settings = Settings(
      difficulty: prefSnapshot.getInt(DIFFICULTY) ?? 1,
      newGame: prefSnapshot.getBool(NEW_GAME) ?? true,
    );

    _settingsRepository.settings = settings;
    emit(SettingsState.updated(settings));
  }

  void _onChangeDifficulty(
    Emitter<SettingsState> emit,
    int value,
  ) {
    state.maybeMap(
        updated: (SettingsUpdated state) {
          var newValue = state.settings.difficulty + value;
          if (newValue < 0 || newValue > 7) return;

          var newSettings = state.settings.copyWith(difficulty: newValue);

          _settingsRepository.settings = newSettings;
          emit(SettingsState.updated(newSettings));
        },
        orElse: () {});
  }

  void _onNewGame(StartNewGame event, Emitter<SettingsState> emit) async {
    void _update(Settings settings) async {
      var snapshot = await _systemPref;
      var newSettings = settings.copyWith(newGame: event.status);

      snapshot.setBool(SettingsBloc.NEW_GAME, event.status);
      snapshot.setInt(SettingsBloc.DIFFICULTY, newSettings.difficulty);
      _settingsRepository.settings = newSettings;
      emit(SettingsState.newGame(newSettings));
    }

    state.maybeWhen(
        updated: (Settings settings) => _update(settings),
        newGame: (Settings settings) => _update(settings),
        orElse: () {});
  }
}
