// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'stats_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StatsStateTearOff {
  const _$StatsStateTearOff();

  _StatsInitial initial(UnitStack stack) {
    return _StatsInitial(
      stack,
    );
  }

  _TurnStarted turnStarted(UnitStack stack) {
    return _TurnStarted(
      stack,
    );
  }

  _TurnEnded turnEnded(UnitStack stack) {
    return _TurnEnded(
      stack,
    );
  }
}

/// @nodoc
const $StatsState = _$StatsStateTearOff();

/// @nodoc
mixin _$StatsState {
  UnitStack get stack => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UnitStack stack) initial,
    required TResult Function(UnitStack stack) turnStarted,
    required TResult Function(UnitStack stack) turnEnded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(UnitStack stack)? initial,
    TResult Function(UnitStack stack)? turnStarted,
    TResult Function(UnitStack stack)? turnEnded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UnitStack stack)? initial,
    TResult Function(UnitStack stack)? turnStarted,
    TResult Function(UnitStack stack)? turnEnded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsInitial value) initial,
    required TResult Function(_TurnStarted value) turnStarted,
    required TResult Function(_TurnEnded value) turnEnded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_TurnStarted value)? turnStarted,
    TResult Function(_TurnEnded value)? turnEnded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_TurnStarted value)? turnStarted,
    TResult Function(_TurnEnded value)? turnEnded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StatsStateCopyWith<StatsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsStateCopyWith<$Res> {
  factory $StatsStateCopyWith(
          StatsState value, $Res Function(StatsState) then) =
      _$StatsStateCopyWithImpl<$Res>;
  $Res call({UnitStack stack});
}

/// @nodoc
class _$StatsStateCopyWithImpl<$Res> implements $StatsStateCopyWith<$Res> {
  _$StatsStateCopyWithImpl(this._value, this._then);

  final StatsState _value;
  // ignore: unused_field
  final $Res Function(StatsState) _then;

  @override
  $Res call({
    Object? stack = freezed,
  }) {
    return _then(_value.copyWith(
      stack: stack == freezed
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as UnitStack,
    ));
  }
}

/// @nodoc
abstract class _$StatsInitialCopyWith<$Res>
    implements $StatsStateCopyWith<$Res> {
  factory _$StatsInitialCopyWith(
          _StatsInitial value, $Res Function(_StatsInitial) then) =
      __$StatsInitialCopyWithImpl<$Res>;
  @override
  $Res call({UnitStack stack});
}

/// @nodoc
class __$StatsInitialCopyWithImpl<$Res> extends _$StatsStateCopyWithImpl<$Res>
    implements _$StatsInitialCopyWith<$Res> {
  __$StatsInitialCopyWithImpl(
      _StatsInitial _value, $Res Function(_StatsInitial) _then)
      : super(_value, (v) => _then(v as _StatsInitial));

  @override
  _StatsInitial get _value => super._value as _StatsInitial;

  @override
  $Res call({
    Object? stack = freezed,
  }) {
    return _then(_StatsInitial(
      stack == freezed
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as UnitStack,
    ));
  }
}

/// @nodoc

class _$_StatsInitial with DiagnosticableTreeMixin implements _StatsInitial {
  const _$_StatsInitial(this.stack);

  @override
  final UnitStack stack;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StatsState.initial(stack: $stack)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StatsState.initial'))
      ..add(DiagnosticsProperty('stack', stack));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StatsInitial &&
            const DeepCollectionEquality().equals(other.stack, stack));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(stack));

  @JsonKey(ignore: true)
  @override
  _$StatsInitialCopyWith<_StatsInitial> get copyWith =>
      __$StatsInitialCopyWithImpl<_StatsInitial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UnitStack stack) initial,
    required TResult Function(UnitStack stack) turnStarted,
    required TResult Function(UnitStack stack) turnEnded,
  }) {
    return initial(stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(UnitStack stack)? initial,
    TResult Function(UnitStack stack)? turnStarted,
    TResult Function(UnitStack stack)? turnEnded,
  }) {
    return initial?.call(stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UnitStack stack)? initial,
    TResult Function(UnitStack stack)? turnStarted,
    TResult Function(UnitStack stack)? turnEnded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsInitial value) initial,
    required TResult Function(_TurnStarted value) turnStarted,
    required TResult Function(_TurnEnded value) turnEnded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_TurnStarted value)? turnStarted,
    TResult Function(_TurnEnded value)? turnEnded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_TurnStarted value)? turnStarted,
    TResult Function(_TurnEnded value)? turnEnded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _StatsInitial implements StatsState {
  const factory _StatsInitial(UnitStack stack) = _$_StatsInitial;

  @override
  UnitStack get stack;
  @override
  @JsonKey(ignore: true)
  _$StatsInitialCopyWith<_StatsInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$TurnStartedCopyWith<$Res>
    implements $StatsStateCopyWith<$Res> {
  factory _$TurnStartedCopyWith(
          _TurnStarted value, $Res Function(_TurnStarted) then) =
      __$TurnStartedCopyWithImpl<$Res>;
  @override
  $Res call({UnitStack stack});
}

/// @nodoc
class __$TurnStartedCopyWithImpl<$Res> extends _$StatsStateCopyWithImpl<$Res>
    implements _$TurnStartedCopyWith<$Res> {
  __$TurnStartedCopyWithImpl(
      _TurnStarted _value, $Res Function(_TurnStarted) _then)
      : super(_value, (v) => _then(v as _TurnStarted));

  @override
  _TurnStarted get _value => super._value as _TurnStarted;

  @override
  $Res call({
    Object? stack = freezed,
  }) {
    return _then(_TurnStarted(
      stack == freezed
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as UnitStack,
    ));
  }
}

/// @nodoc

class _$_TurnStarted with DiagnosticableTreeMixin implements _TurnStarted {
  const _$_TurnStarted(this.stack);

  @override
  final UnitStack stack;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StatsState.turnStarted(stack: $stack)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StatsState.turnStarted'))
      ..add(DiagnosticsProperty('stack', stack));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TurnStarted &&
            const DeepCollectionEquality().equals(other.stack, stack));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(stack));

  @JsonKey(ignore: true)
  @override
  _$TurnStartedCopyWith<_TurnStarted> get copyWith =>
      __$TurnStartedCopyWithImpl<_TurnStarted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UnitStack stack) initial,
    required TResult Function(UnitStack stack) turnStarted,
    required TResult Function(UnitStack stack) turnEnded,
  }) {
    return turnStarted(stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(UnitStack stack)? initial,
    TResult Function(UnitStack stack)? turnStarted,
    TResult Function(UnitStack stack)? turnEnded,
  }) {
    return turnStarted?.call(stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UnitStack stack)? initial,
    TResult Function(UnitStack stack)? turnStarted,
    TResult Function(UnitStack stack)? turnEnded,
    required TResult orElse(),
  }) {
    if (turnStarted != null) {
      return turnStarted(stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsInitial value) initial,
    required TResult Function(_TurnStarted value) turnStarted,
    required TResult Function(_TurnEnded value) turnEnded,
  }) {
    return turnStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_TurnStarted value)? turnStarted,
    TResult Function(_TurnEnded value)? turnEnded,
  }) {
    return turnStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_TurnStarted value)? turnStarted,
    TResult Function(_TurnEnded value)? turnEnded,
    required TResult orElse(),
  }) {
    if (turnStarted != null) {
      return turnStarted(this);
    }
    return orElse();
  }
}

abstract class _TurnStarted implements StatsState {
  const factory _TurnStarted(UnitStack stack) = _$_TurnStarted;

  @override
  UnitStack get stack;
  @override
  @JsonKey(ignore: true)
  _$TurnStartedCopyWith<_TurnStarted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$TurnEndedCopyWith<$Res> implements $StatsStateCopyWith<$Res> {
  factory _$TurnEndedCopyWith(
          _TurnEnded value, $Res Function(_TurnEnded) then) =
      __$TurnEndedCopyWithImpl<$Res>;
  @override
  $Res call({UnitStack stack});
}

/// @nodoc
class __$TurnEndedCopyWithImpl<$Res> extends _$StatsStateCopyWithImpl<$Res>
    implements _$TurnEndedCopyWith<$Res> {
  __$TurnEndedCopyWithImpl(_TurnEnded _value, $Res Function(_TurnEnded) _then)
      : super(_value, (v) => _then(v as _TurnEnded));

  @override
  _TurnEnded get _value => super._value as _TurnEnded;

  @override
  $Res call({
    Object? stack = freezed,
  }) {
    return _then(_TurnEnded(
      stack == freezed
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as UnitStack,
    ));
  }
}

/// @nodoc

class _$_TurnEnded with DiagnosticableTreeMixin implements _TurnEnded {
  const _$_TurnEnded(this.stack);

  @override
  final UnitStack stack;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StatsState.turnEnded(stack: $stack)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StatsState.turnEnded'))
      ..add(DiagnosticsProperty('stack', stack));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TurnEnded &&
            const DeepCollectionEquality().equals(other.stack, stack));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(stack));

  @JsonKey(ignore: true)
  @override
  _$TurnEndedCopyWith<_TurnEnded> get copyWith =>
      __$TurnEndedCopyWithImpl<_TurnEnded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UnitStack stack) initial,
    required TResult Function(UnitStack stack) turnStarted,
    required TResult Function(UnitStack stack) turnEnded,
  }) {
    return turnEnded(stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(UnitStack stack)? initial,
    TResult Function(UnitStack stack)? turnStarted,
    TResult Function(UnitStack stack)? turnEnded,
  }) {
    return turnEnded?.call(stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UnitStack stack)? initial,
    TResult Function(UnitStack stack)? turnStarted,
    TResult Function(UnitStack stack)? turnEnded,
    required TResult orElse(),
  }) {
    if (turnEnded != null) {
      return turnEnded(stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsInitial value) initial,
    required TResult Function(_TurnStarted value) turnStarted,
    required TResult Function(_TurnEnded value) turnEnded,
  }) {
    return turnEnded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_TurnStarted value)? turnStarted,
    TResult Function(_TurnEnded value)? turnEnded,
  }) {
    return turnEnded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_TurnStarted value)? turnStarted,
    TResult Function(_TurnEnded value)? turnEnded,
    required TResult orElse(),
  }) {
    if (turnEnded != null) {
      return turnEnded(this);
    }
    return orElse();
  }
}

abstract class _TurnEnded implements StatsState {
  const factory _TurnEnded(UnitStack stack) = _$_TurnEnded;

  @override
  UnitStack get stack;
  @override
  @JsonKey(ignore: true)
  _$TurnEndedCopyWith<_TurnEnded> get copyWith =>
      throw _privateConstructorUsedError;
}
