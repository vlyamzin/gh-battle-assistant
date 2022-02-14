// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SettingsStateTearOff {
  const _$SettingsStateTearOff();

  _SettingsInitial initial() {
    return _SettingsInitial();
  }

  SettingsUpdated updated(Settings settings) {
    return SettingsUpdated(
      settings,
    );
  }

  SettingsSaved saved() {
    return SettingsSaved();
  }

  NewGame newGame(Settings settings) {
    return NewGame(
      settings,
    );
  }

  _SettingsLoadingFailed failed() {
    return _SettingsLoadingFailed();
  }
}

/// @nodoc
const $SettingsState = _$SettingsStateTearOff();

/// @nodoc
mixin _$SettingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Settings settings) updated,
    required TResult Function() saved,
    required TResult Function(Settings settings) newGame,
    required TResult Function() failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SettingsInitial value) initial,
    required TResult Function(SettingsUpdated value) updated,
    required TResult Function(SettingsSaved value) saved,
    required TResult Function(NewGame value) newGame,
    required TResult Function(_SettingsLoadingFailed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  final SettingsState _value;
  // ignore: unused_field
  final $Res Function(SettingsState) _then;
}

/// @nodoc
abstract class _$SettingsInitialCopyWith<$Res> {
  factory _$SettingsInitialCopyWith(
          _SettingsInitial value, $Res Function(_SettingsInitial) then) =
      __$SettingsInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$SettingsInitialCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsInitialCopyWith<$Res> {
  __$SettingsInitialCopyWithImpl(
      _SettingsInitial _value, $Res Function(_SettingsInitial) _then)
      : super(_value, (v) => _then(v as _SettingsInitial));

  @override
  _SettingsInitial get _value => super._value as _SettingsInitial;
}

/// @nodoc

class _$_SettingsInitial implements _SettingsInitial {
  _$_SettingsInitial();

  @override
  String toString() {
    return 'SettingsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SettingsInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Settings settings) updated,
    required TResult Function() saved,
    required TResult Function(Settings settings) newGame,
    required TResult Function() failed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
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
    required TResult Function(_SettingsInitial value) initial,
    required TResult Function(SettingsUpdated value) updated,
    required TResult Function(SettingsSaved value) saved,
    required TResult Function(NewGame value) newGame,
    required TResult Function(_SettingsLoadingFailed value) failed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _SettingsInitial implements SettingsState {
  factory _SettingsInitial() = _$_SettingsInitial;
}

/// @nodoc
abstract class $SettingsUpdatedCopyWith<$Res> {
  factory $SettingsUpdatedCopyWith(
          SettingsUpdated value, $Res Function(SettingsUpdated) then) =
      _$SettingsUpdatedCopyWithImpl<$Res>;
  $Res call({Settings settings});
}

/// @nodoc
class _$SettingsUpdatedCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsUpdatedCopyWith<$Res> {
  _$SettingsUpdatedCopyWithImpl(
      SettingsUpdated _value, $Res Function(SettingsUpdated) _then)
      : super(_value, (v) => _then(v as SettingsUpdated));

  @override
  SettingsUpdated get _value => super._value as SettingsUpdated;

  @override
  $Res call({
    Object? settings = freezed,
  }) {
    return _then(SettingsUpdated(
      settings == freezed
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Settings,
    ));
  }
}

/// @nodoc

class _$SettingsUpdated implements SettingsUpdated {
  _$SettingsUpdated(this.settings);

  @override
  final Settings settings;

  @override
  String toString() {
    return 'SettingsState.updated(settings: $settings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsUpdated &&
            const DeepCollectionEquality().equals(other.settings, settings));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(settings));

  @JsonKey(ignore: true)
  @override
  $SettingsUpdatedCopyWith<SettingsUpdated> get copyWith =>
      _$SettingsUpdatedCopyWithImpl<SettingsUpdated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Settings settings) updated,
    required TResult Function() saved,
    required TResult Function(Settings settings) newGame,
    required TResult Function() failed,
  }) {
    return updated(settings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
  }) {
    return updated?.call(settings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(settings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SettingsInitial value) initial,
    required TResult Function(SettingsUpdated value) updated,
    required TResult Function(SettingsSaved value) saved,
    required TResult Function(NewGame value) newGame,
    required TResult Function(_SettingsLoadingFailed value) failed,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class SettingsUpdated implements SettingsState {
  factory SettingsUpdated(Settings settings) = _$SettingsUpdated;

  Settings get settings;
  @JsonKey(ignore: true)
  $SettingsUpdatedCopyWith<SettingsUpdated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsSavedCopyWith<$Res> {
  factory $SettingsSavedCopyWith(
          SettingsSaved value, $Res Function(SettingsSaved) then) =
      _$SettingsSavedCopyWithImpl<$Res>;
}

/// @nodoc
class _$SettingsSavedCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsSavedCopyWith<$Res> {
  _$SettingsSavedCopyWithImpl(
      SettingsSaved _value, $Res Function(SettingsSaved) _then)
      : super(_value, (v) => _then(v as SettingsSaved));

  @override
  SettingsSaved get _value => super._value as SettingsSaved;
}

/// @nodoc

class _$SettingsSaved implements SettingsSaved {
  _$SettingsSaved();

  @override
  String toString() {
    return 'SettingsState.saved()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsSaved);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Settings settings) updated,
    required TResult Function() saved,
    required TResult Function(Settings settings) newGame,
    required TResult Function() failed,
  }) {
    return saved();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
  }) {
    return saved?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SettingsInitial value) initial,
    required TResult Function(SettingsUpdated value) updated,
    required TResult Function(SettingsSaved value) saved,
    required TResult Function(NewGame value) newGame,
    required TResult Function(_SettingsLoadingFailed value) failed,
  }) {
    return saved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
  }) {
    return saved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class SettingsSaved implements SettingsState {
  factory SettingsSaved() = _$SettingsSaved;
}

/// @nodoc
abstract class $NewGameCopyWith<$Res> {
  factory $NewGameCopyWith(NewGame value, $Res Function(NewGame) then) =
      _$NewGameCopyWithImpl<$Res>;
  $Res call({Settings settings});
}

/// @nodoc
class _$NewGameCopyWithImpl<$Res> extends _$SettingsStateCopyWithImpl<$Res>
    implements $NewGameCopyWith<$Res> {
  _$NewGameCopyWithImpl(NewGame _value, $Res Function(NewGame) _then)
      : super(_value, (v) => _then(v as NewGame));

  @override
  NewGame get _value => super._value as NewGame;

  @override
  $Res call({
    Object? settings = freezed,
  }) {
    return _then(NewGame(
      settings == freezed
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Settings,
    ));
  }
}

/// @nodoc

class _$NewGame implements NewGame {
  _$NewGame(this.settings);

  @override
  final Settings settings;

  @override
  String toString() {
    return 'SettingsState.newGame(settings: $settings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NewGame &&
            const DeepCollectionEquality().equals(other.settings, settings));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(settings));

  @JsonKey(ignore: true)
  @override
  $NewGameCopyWith<NewGame> get copyWith =>
      _$NewGameCopyWithImpl<NewGame>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Settings settings) updated,
    required TResult Function() saved,
    required TResult Function(Settings settings) newGame,
    required TResult Function() failed,
  }) {
    return newGame(settings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
  }) {
    return newGame?.call(settings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
    required TResult orElse(),
  }) {
    if (newGame != null) {
      return newGame(settings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SettingsInitial value) initial,
    required TResult Function(SettingsUpdated value) updated,
    required TResult Function(SettingsSaved value) saved,
    required TResult Function(NewGame value) newGame,
    required TResult Function(_SettingsLoadingFailed value) failed,
  }) {
    return newGame(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
  }) {
    return newGame?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
    required TResult orElse(),
  }) {
    if (newGame != null) {
      return newGame(this);
    }
    return orElse();
  }
}

abstract class NewGame implements SettingsState {
  factory NewGame(Settings settings) = _$NewGame;

  Settings get settings;
  @JsonKey(ignore: true)
  $NewGameCopyWith<NewGame> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SettingsLoadingFailedCopyWith<$Res> {
  factory _$SettingsLoadingFailedCopyWith(_SettingsLoadingFailed value,
          $Res Function(_SettingsLoadingFailed) then) =
      __$SettingsLoadingFailedCopyWithImpl<$Res>;
}

/// @nodoc
class __$SettingsLoadingFailedCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsLoadingFailedCopyWith<$Res> {
  __$SettingsLoadingFailedCopyWithImpl(_SettingsLoadingFailed _value,
      $Res Function(_SettingsLoadingFailed) _then)
      : super(_value, (v) => _then(v as _SettingsLoadingFailed));

  @override
  _SettingsLoadingFailed get _value => super._value as _SettingsLoadingFailed;
}

/// @nodoc

class _$_SettingsLoadingFailed implements _SettingsLoadingFailed {
  _$_SettingsLoadingFailed();

  @override
  String toString() {
    return 'SettingsState.failed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SettingsLoadingFailed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Settings settings) updated,
    required TResult Function() saved,
    required TResult Function(Settings settings) newGame,
    required TResult Function() failed,
  }) {
    return failed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
  }) {
    return failed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Settings settings)? updated,
    TResult Function()? saved,
    TResult Function(Settings settings)? newGame,
    TResult Function()? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SettingsInitial value) initial,
    required TResult Function(SettingsUpdated value) updated,
    required TResult Function(SettingsSaved value) saved,
    required TResult Function(NewGame value) newGame,
    required TResult Function(_SettingsLoadingFailed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SettingsInitial value)? initial,
    TResult Function(SettingsUpdated value)? updated,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(NewGame value)? newGame,
    TResult Function(_SettingsLoadingFailed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _SettingsLoadingFailed implements SettingsState {
  factory _SettingsLoadingFailed() = _$_SettingsLoadingFailed;
}
