// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'unit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UnitStateTearOff {
  const _$UnitStateTearOff();

  _$UnitReady ready(Unit unit, [Effect? selectedActivity]) {
    return _$UnitReady(
      unit,
      selectedActivity,
    );
  }
}

/// @nodoc
const $UnitState = _$UnitStateTearOff();

/// @nodoc
mixin _$UnitState {
  Unit get unit => throw _privateConstructorUsedError;
  Effect? get selectedActivity => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Unit unit, Effect? selectedActivity) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Unit unit, Effect? selectedActivity)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Unit unit, Effect? selectedActivity)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_$UnitReady value) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_$UnitReady value)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_$UnitReady value)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UnitStateCopyWith<UnitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitStateCopyWith<$Res> {
  factory $UnitStateCopyWith(UnitState value, $Res Function(UnitState) then) =
      _$UnitStateCopyWithImpl<$Res>;
  $Res call({Unit unit, Effect? selectedActivity});
}

/// @nodoc
class _$UnitStateCopyWithImpl<$Res> implements $UnitStateCopyWith<$Res> {
  _$UnitStateCopyWithImpl(this._value, this._then);

  final UnitState _value;
  // ignore: unused_field
  final $Res Function(UnitState) _then;

  @override
  $Res call({
    Object? unit = freezed,
    Object? selectedActivity = freezed,
  }) {
    return _then(_value.copyWith(
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit,
      selectedActivity: selectedActivity == freezed
          ? _value.selectedActivity
          : selectedActivity // ignore: cast_nullable_to_non_nullable
              as Effect?,
    ));
  }
}

/// @nodoc
abstract class _$$UnitReadyCopyWith<$Res> implements $UnitStateCopyWith<$Res> {
  factory _$$UnitReadyCopyWith(
          _$UnitReady value, $Res Function(_$UnitReady) then) =
      __$$UnitReadyCopyWithImpl<$Res>;
  @override
  $Res call({Unit unit, Effect? selectedActivity});
}

/// @nodoc
class __$$UnitReadyCopyWithImpl<$Res> extends _$UnitStateCopyWithImpl<$Res>
    implements _$$UnitReadyCopyWith<$Res> {
  __$$UnitReadyCopyWithImpl(
      _$UnitReady _value, $Res Function(_$UnitReady) _then)
      : super(_value, (v) => _then(v as _$UnitReady));

  @override
  _$UnitReady get _value => super._value as _$UnitReady;

  @override
  $Res call({
    Object? unit = freezed,
    Object? selectedActivity = freezed,
  }) {
    return _then(_$UnitReady(
      unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit,
      selectedActivity == freezed
          ? _value.selectedActivity
          : selectedActivity // ignore: cast_nullable_to_non_nullable
              as Effect?,
    ));
  }
}

/// @nodoc

class _$_$UnitReady with DiagnosticableTreeMixin implements _$UnitReady {
  const _$_$UnitReady(this.unit, [this.selectedActivity]);

  @override
  final Unit unit;
  @override
  final Effect? selectedActivity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UnitState.ready(unit: $unit, selectedActivity: $selectedActivity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UnitState.ready'))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('selectedActivity', selectedActivity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnitReady &&
            const DeepCollectionEquality().equals(other.unit, unit) &&
            const DeepCollectionEquality()
                .equals(other.selectedActivity, selectedActivity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(unit),
      const DeepCollectionEquality().hash(selectedActivity));

  @JsonKey(ignore: true)
  @override
  _$$UnitReadyCopyWith<_$UnitReady> get copyWith =>
      __$$UnitReadyCopyWithImpl<_$UnitReady>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Unit unit, Effect? selectedActivity) ready,
  }) {
    return ready(unit, selectedActivity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Unit unit, Effect? selectedActivity)? ready,
  }) {
    return ready?.call(unit, selectedActivity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Unit unit, Effect? selectedActivity)? ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(unit, selectedActivity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_$UnitReady value) ready,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_$UnitReady value)? ready,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_$UnitReady value)? ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class _$UnitReady implements UnitState {
  const factory _$UnitReady(Unit unit, [Effect? selectedActivity]) =
      _$_$UnitReady;

  @override
  Unit get unit;
  @override
  Effect? get selectedActivity;
  @override
  @JsonKey(ignore: true)
  _$$UnitReadyCopyWith<_$UnitReady> get copyWith =>
      throw _privateConstructorUsedError;
}
