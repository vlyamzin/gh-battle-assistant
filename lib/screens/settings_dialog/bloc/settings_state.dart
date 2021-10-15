import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/settings_dialog.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  factory SettingsState.initial() = _SettingsInitialS;
  factory SettingsState.updated(Settings settings) = SettingsUpdatedS;
  factory SettingsState.saved() = SettingsSavedS;
  factory SettingsState.failed() = _SettingsLoadingFailed;
}
