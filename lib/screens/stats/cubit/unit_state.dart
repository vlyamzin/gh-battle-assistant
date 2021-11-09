import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

part 'unit_state.freezed.dart';

@freezed
class UnitState with _$UnitState {
  const factory UnitState.ready(Unit unit) = _$UnitReady;
}
