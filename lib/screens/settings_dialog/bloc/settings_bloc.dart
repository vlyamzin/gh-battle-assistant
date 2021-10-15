import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/bloc/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings_dialog.dart';

part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const DIFFICULTY = 'difficulty';
  final _systemPref = SharedPreferences.getInstance();
  SettingsBloc() : super(SettingsState.initial()) {
    on<SettingsLoadE>(_onSettingsLoad);
    on<SettingsSaveE>((_, emit) async {
      var status = await _onSaveToStorage(emit);
      if (status) {
        state.maybeMap(
          updated: (SettingsUpdatedS state) {
            var settings = state.settings;

            emit(SettingsState.saved());
            emit(SettingsState.updated(settings));
          },
          orElse: () {},
        );
      }
      ;
    });
    on<SettingsDifficultyIncreaseE>(
        (event, emit) => _onChangeDifficulty(emit, 1));
    on<SettingsDifficultyDecreaseE>(
        (event, emit) => _onChangeDifficulty(emit, -1));
  }

  void _onSettingsLoad(SettingsLoadE event, Emitter<SettingsState> emit) async {
    var prefSnapshot = await _systemPref;
    emit(
      SettingsState.updated(
        Settings(difficulty: prefSnapshot.getInt('difficulty') ?? 1),
      ),
    );
  }

  void _onChangeDifficulty(
    Emitter<SettingsState> emit,
    int value,
  ) {
    state.maybeMap(
        updated: (SettingsUpdatedS state) {
          var oldValue = state.settings.difficulty;

          emit(
            SettingsState.updated(
              state.settings.copyWith(difficulty: oldValue + value),
            ),
          );
        },
        orElse: () {});
  }

  Future<bool> _onSaveToStorage(Emitter<SettingsState> emit) async {
    return state.maybeWhen<Future<bool>>(
        updated: (Settings settings) async {
          var snapshot = await _systemPref;
          var difficulty = settings.difficulty;

          return snapshot.setInt(SettingsBloc.DIFFICULTY, difficulty);
        },
        orElse: () => Future.value(false));
  }
}
