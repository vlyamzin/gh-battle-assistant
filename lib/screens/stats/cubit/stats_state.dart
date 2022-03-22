import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';

part 'stats_state.freezed.dart';

@freezed
class StatsState with _$StatsState {
  const factory StatsState.initial(UnitStack stack) = _StatsInitial;
  const factory StatsState.turnStarted(UnitStack stack) = TurnStarted;
  const factory StatsState.turnEnded(UnitStack stack) = _TurnEnded;
  const factory StatsState.navigateBack() = _NavigateBack;
}
