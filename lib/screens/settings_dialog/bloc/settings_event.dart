part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsLoadE extends SettingsEvent {}

class SettingsDifficultyIncreaseE extends SettingsEvent {}

class SettingsDifficultyDecreaseE extends SettingsEvent {}

class SettingsSaveE extends SettingsEvent {}

class StartNewGame extends SettingsEvent {
  final bool status;

  StartNewGame(this.status) : super();

  @override
  List<Object> get props => [status];
}
