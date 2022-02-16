import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/common/enums/activity_type.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

/// [UserAction] model keeps the information about user action that they want to apply to the particular [Unit]
@immutable
class UserAction extends Equatable {
  final Effect actionType;
  final dynamic value;

  const UserAction({required this.actionType, required this.value});

  UserAction copyWith({
    Effect? actionType,
    dynamic value,
  }) {
    return UserAction(
      actionType: actionType ?? this.actionType,
      value: value ?? this.value,
    );
  }

  UserAction updateActionType(Effect actionType, dynamic defaultValue) {
    return copyWith(actionType: actionType, value: defaultValue);
  }

  UserAction updateValue<T>(T value) {
    return copyWith(value: value);
  }

  bool isSubtype<S, T>() => <S>[] is List<T>;

  @override
  List<Object?> get props => [actionType, value];
}

@immutable
class ActionItem<T> extends Equatable {
  final ActivityType type;
  final T value;

  const ActionItem({required this.type, required this.value});

  bool has(ActivityType key) => key == type;

  ActionItem copyWith<T>({required T newValue}) {
    if (isSubtype<T, int>()) {
      var original = value as int;
      var newInt = newValue as int;
      return ActionItem(type: type, value: original + newInt);
    } else {
      return ActionItem(type: type, value: newValue);
    }
  }

  bool isSubtype<S, T>() => <S>[] is List<T>;

  @override
  String toString() {
    if (value is int) {
      return value.toString();
    } else {
      return '';
    }
  }

  @override
  List<Object?> get props => [type, value];
}
