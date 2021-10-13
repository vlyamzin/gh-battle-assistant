import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings_dialog.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const DIFFICULTY = 'difficulty';
  final _systemPref = SharedPreferences.getInstance();
  SettingsBloc() : super(SettingsInitialS()) {
    on<SettingsLoadE>(_onSettingsLoad);
    on<SettingsSaveE>((_, emit) async {
      var status = await _onSaveToStorage(emit);
      if (status) {
        if (state is SettingsUpdatedS) {
          var _state = state as SettingsUpdatedS;
          emit(SettingsSavedS());
          emit(SettingsUpdatedS(_state.settings.copyWith()));
        }
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
      SettingsUpdatedS(
        Settings(difficulty: prefSnapshot.getInt('difficulty') ?? 1),
      ),
    );
  }

  void _onChangeDifficulty(
    Emitter<SettingsState> emit,
    int value,
  ) {
    if (state is SettingsUpdatedS) {
      var oldValue = (state as SettingsUpdatedS).settings.difficulty;
      var updatedSettings = (state as SettingsUpdatedS)
          .settings
          .copyWith(difficulty: oldValue + value);
      emit(SettingsUpdatedS(updatedSettings));
    }
  }

  Future<bool> _onSaveToStorage(Emitter<SettingsState> emit) async {
    if (state is SettingsUpdatedS) {
      var snapshot = await _systemPref;
      var difficulty = (state as SettingsUpdatedS).settings.difficulty;

      return snapshot.setInt(SettingsBloc.DIFFICULTY, difficulty);
    } else {
      return Future.value(false);
    }
  }
}
