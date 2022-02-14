import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';

part 'enemies_state.freezed.dart';
part 'enemies_state.g.dart';

@freezed
class EnemiesState with _$EnemiesState {
  factory EnemiesState.initial() = _EnemiesInitial;

  factory EnemiesState.loaded(Enemies enemies) = EnemiesLoaded;

  factory EnemiesState.fromJson(Map<String, dynamic> json) =>
      _$EnemiesStateFromJson(json);
}
