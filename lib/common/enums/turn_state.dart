import 'package:json_annotation/json_annotation.dart';

enum TurnState {
  @JsonValue(0)
  idle,
  @JsonValue(1)
  started,
  @JsonValue(2)
  ended
}
