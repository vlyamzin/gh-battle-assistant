part of 'settings_bloc.dart';

@immutable
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitialS extends SettingsState {}

class SettingsUpdatedS extends SettingsState {
  final Settings settings;
  const SettingsUpdatedS(this.settings);

  @override
  List<Object> get props => [settings];
}

class SettingsSavedS extends SettingsState {}

class SettingsLoadingFailed extends SettingsState {}
