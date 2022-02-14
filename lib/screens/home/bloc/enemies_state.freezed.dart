// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'enemies_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EnemiesState _$EnemiesStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initial':
      return _EnemiesInitial.fromJson(json);
    case 'loaded':
      return EnemiesLoaded.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'EnemiesState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$EnemiesStateTearOff {
  const _$EnemiesStateTearOff();

  _EnemiesInitial initial() {
    return _EnemiesInitial();
  }

  EnemiesLoaded loaded(Enemies enemies) {
    return EnemiesLoaded(
      enemies,
    );
  }

  EnemiesState fromJson(Map<String, Object?> json) {
    return EnemiesState.fromJson(json);
  }
}

/// @nodoc
const $EnemiesState = _$EnemiesStateTearOff();

/// @nodoc
mixin _$EnemiesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Enemies enemies) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Enemies enemies)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Enemies enemies)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EnemiesInitial value) initial,
    required TResult Function(EnemiesLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EnemiesInitial value)? initial,
    TResult Function(EnemiesLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EnemiesInitial value)? initial,
    TResult Function(EnemiesLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnemiesStateCopyWith<$Res> {
  factory $EnemiesStateCopyWith(
          EnemiesState value, $Res Function(EnemiesState) then) =
      _$EnemiesStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$EnemiesStateCopyWithImpl<$Res> implements $EnemiesStateCopyWith<$Res> {
  _$EnemiesStateCopyWithImpl(this._value, this._then);

  final EnemiesState _value;
  // ignore: unused_field
  final $Res Function(EnemiesState) _then;
}

/// @nodoc
abstract class _$EnemiesInitialCopyWith<$Res> {
  factory _$EnemiesInitialCopyWith(
          _EnemiesInitial value, $Res Function(_EnemiesInitial) then) =
      __$EnemiesInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$EnemiesInitialCopyWithImpl<$Res>
    extends _$EnemiesStateCopyWithImpl<$Res>
    implements _$EnemiesInitialCopyWith<$Res> {
  __$EnemiesInitialCopyWithImpl(
      _EnemiesInitial _value, $Res Function(_EnemiesInitial) _then)
      : super(_value, (v) => _then(v as _EnemiesInitial));

  @override
  _EnemiesInitial get _value => super._value as _EnemiesInitial;
}

/// @nodoc
@JsonSerializable()
class _$_EnemiesInitial implements _EnemiesInitial {
  _$_EnemiesInitial({String? $type}) : $type = $type ?? 'initial';

  factory _$_EnemiesInitial.fromJson(Map<String, dynamic> json) =>
      _$$_EnemiesInitialFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'EnemiesState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _EnemiesInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Enemies enemies) loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Enemies enemies)? loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Enemies enemies)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EnemiesInitial value) initial,
    required TResult Function(EnemiesLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EnemiesInitial value)? initial,
    TResult Function(EnemiesLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EnemiesInitial value)? initial,
    TResult Function(EnemiesLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_EnemiesInitialToJson(this);
  }
}

abstract class _EnemiesInitial implements EnemiesState {
  factory _EnemiesInitial() = _$_EnemiesInitial;

  factory _EnemiesInitial.fromJson(Map<String, dynamic> json) =
      _$_EnemiesInitial.fromJson;
}

/// @nodoc
abstract class $EnemiesLoadedCopyWith<$Res> {
  factory $EnemiesLoadedCopyWith(
          EnemiesLoaded value, $Res Function(EnemiesLoaded) then) =
      _$EnemiesLoadedCopyWithImpl<$Res>;
  $Res call({Enemies enemies});
}

/// @nodoc
class _$EnemiesLoadedCopyWithImpl<$Res> extends _$EnemiesStateCopyWithImpl<$Res>
    implements $EnemiesLoadedCopyWith<$Res> {
  _$EnemiesLoadedCopyWithImpl(
      EnemiesLoaded _value, $Res Function(EnemiesLoaded) _then)
      : super(_value, (v) => _then(v as EnemiesLoaded));

  @override
  EnemiesLoaded get _value => super._value as EnemiesLoaded;

  @override
  $Res call({
    Object? enemies = freezed,
  }) {
    return _then(EnemiesLoaded(
      enemies == freezed
          ? _value.enemies
          : enemies // ignore: cast_nullable_to_non_nullable
              as Enemies,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnemiesLoaded implements EnemiesLoaded {
  _$EnemiesLoaded(this.enemies, {String? $type}) : $type = $type ?? 'loaded';

  factory _$EnemiesLoaded.fromJson(Map<String, dynamic> json) =>
      _$$EnemiesLoadedFromJson(json);

  @override
  final Enemies enemies;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'EnemiesState.loaded(enemies: $enemies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnemiesLoaded &&
            const DeepCollectionEquality().equals(other.enemies, enemies));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(enemies));

  @JsonKey(ignore: true)
  @override
  $EnemiesLoadedCopyWith<EnemiesLoaded> get copyWith =>
      _$EnemiesLoadedCopyWithImpl<EnemiesLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Enemies enemies) loaded,
  }) {
    return loaded(enemies);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Enemies enemies)? loaded,
  }) {
    return loaded?.call(enemies);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Enemies enemies)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(enemies);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EnemiesInitial value) initial,
    required TResult Function(EnemiesLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EnemiesInitial value)? initial,
    TResult Function(EnemiesLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EnemiesInitial value)? initial,
    TResult Function(EnemiesLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EnemiesLoadedToJson(this);
  }
}

abstract class EnemiesLoaded implements EnemiesState {
  factory EnemiesLoaded(Enemies enemies) = _$EnemiesLoaded;

  factory EnemiesLoaded.fromJson(Map<String, dynamic> json) =
      _$EnemiesLoaded.fromJson;

  Enemies get enemies;
  @JsonKey(ignore: true)
  $EnemiesLoadedCopyWith<EnemiesLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}
