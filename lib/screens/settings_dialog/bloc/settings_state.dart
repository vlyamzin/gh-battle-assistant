import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/settings_dialog.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState.initial() = _SettingsInitial;
  factory SettingsState.updated(Settings settings) = SettingsUpdated;
  factory SettingsState.saved() = SettingsSaved;
  factory SettingsState.newGame(Settings settings) = NewGame;
  factory SettingsState.failed() = _SettingsLoadingFailed;
}
