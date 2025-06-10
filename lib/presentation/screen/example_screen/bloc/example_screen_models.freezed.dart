// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_screen_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExampleScreenEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() hiveCall,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? hiveCall,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? hiveCall,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExampleScreenHiveCallEvent value) hiveCall,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExampleScreenHiveCallEvent value)? hiveCall,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExampleScreenHiveCallEvent value)? hiveCall,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleScreenEventCopyWith<$Res> {
  factory $ExampleScreenEventCopyWith(
          ExampleScreenEvent value, $Res Function(ExampleScreenEvent) then) =
      _$ExampleScreenEventCopyWithImpl<$Res, ExampleScreenEvent>;
}

/// @nodoc
class _$ExampleScreenEventCopyWithImpl<$Res, $Val extends ExampleScreenEvent>
    implements $ExampleScreenEventCopyWith<$Res> {
  _$ExampleScreenEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ExampleScreenHiveCallEventImplCopyWith<$Res> {
  factory _$$ExampleScreenHiveCallEventImplCopyWith(
          _$ExampleScreenHiveCallEventImpl value,
          $Res Function(_$ExampleScreenHiveCallEventImpl) then) =
      __$$ExampleScreenHiveCallEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExampleScreenHiveCallEventImplCopyWithImpl<$Res>
    extends _$ExampleScreenEventCopyWithImpl<$Res,
        _$ExampleScreenHiveCallEventImpl>
    implements _$$ExampleScreenHiveCallEventImplCopyWith<$Res> {
  __$$ExampleScreenHiveCallEventImplCopyWithImpl(
      _$ExampleScreenHiveCallEventImpl _value,
      $Res Function(_$ExampleScreenHiveCallEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ExampleScreenHiveCallEventImpl implements ExampleScreenHiveCallEvent {
  const _$ExampleScreenHiveCallEventImpl();

  @override
  String toString() {
    return 'ExampleScreenEvent.hiveCall()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExampleScreenHiveCallEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() hiveCall,
  }) {
    return hiveCall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? hiveCall,
  }) {
    return hiveCall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? hiveCall,
    required TResult orElse(),
  }) {
    if (hiveCall != null) {
      return hiveCall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExampleScreenHiveCallEvent value) hiveCall,
  }) {
    return hiveCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExampleScreenHiveCallEvent value)? hiveCall,
  }) {
    return hiveCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExampleScreenHiveCallEvent value)? hiveCall,
    required TResult orElse(),
  }) {
    if (hiveCall != null) {
      return hiveCall(this);
    }
    return orElse();
  }
}

abstract class ExampleScreenHiveCallEvent implements ExampleScreenEvent {
  const factory ExampleScreenHiveCallEvent() = _$ExampleScreenHiveCallEventImpl;
}

/// @nodoc
mixin _$ExampleScreenState {
  String get hive => throw _privateConstructorUsedError;
  ProductEntity? get product => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExampleScreenStateCopyWith<ExampleScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleScreenStateCopyWith<$Res> {
  factory $ExampleScreenStateCopyWith(
          ExampleScreenState value, $Res Function(ExampleScreenState) then) =
      _$ExampleScreenStateCopyWithImpl<$Res, ExampleScreenState>;
  @useResult
  $Res call({String hive, ProductEntity? product});
}

/// @nodoc
class _$ExampleScreenStateCopyWithImpl<$Res, $Val extends ExampleScreenState>
    implements $ExampleScreenStateCopyWith<$Res> {
  _$ExampleScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hive = null,
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      hive: null == hive
          ? _value.hive
          : hive // ignore: cast_nullable_to_non_nullable
              as String,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductEntity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExampleScreenStateImplCopyWith<$Res>
    implements $ExampleScreenStateCopyWith<$Res> {
  factory _$$ExampleScreenStateImplCopyWith(_$ExampleScreenStateImpl value,
          $Res Function(_$ExampleScreenStateImpl) then) =
      __$$ExampleScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String hive, ProductEntity? product});
}

/// @nodoc
class __$$ExampleScreenStateImplCopyWithImpl<$Res>
    extends _$ExampleScreenStateCopyWithImpl<$Res, _$ExampleScreenStateImpl>
    implements _$$ExampleScreenStateImplCopyWith<$Res> {
  __$$ExampleScreenStateImplCopyWithImpl(_$ExampleScreenStateImpl _value,
      $Res Function(_$ExampleScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hive = null,
    Object? product = freezed,
  }) {
    return _then(_$ExampleScreenStateImpl(
      hive: null == hive
          ? _value.hive
          : hive // ignore: cast_nullable_to_non_nullable
              as String,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductEntity?,
    ));
  }
}

/// @nodoc

class _$ExampleScreenStateImpl implements _ExampleScreenState {
  const _$ExampleScreenStateImpl({this.hive = '', this.product});

  @override
  @JsonKey()
  final String hive;
  @override
  final ProductEntity? product;

  @override
  String toString() {
    return 'ExampleScreenState(hive: $hive, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExampleScreenStateImpl &&
            (identical(other.hive, hive) || other.hive == hive) &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hive, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExampleScreenStateImplCopyWith<_$ExampleScreenStateImpl> get copyWith =>
      __$$ExampleScreenStateImplCopyWithImpl<_$ExampleScreenStateImpl>(
          this, _$identity);
}

abstract class _ExampleScreenState implements ExampleScreenState {
  const factory _ExampleScreenState(
      {final String hive,
      final ProductEntity? product}) = _$ExampleScreenStateImpl;

  @override
  String get hive;
  @override
  ProductEntity? get product;
  @override
  @JsonKey(ignore: true)
  _$$ExampleScreenStateImplCopyWith<_$ExampleScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExampleScreenSR {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFinished,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFinished value) loadFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFinished value)? loadFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFinished value)? loadFinished,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleScreenSRCopyWith<$Res> {
  factory $ExampleScreenSRCopyWith(
          ExampleScreenSR value, $Res Function(ExampleScreenSR) then) =
      _$ExampleScreenSRCopyWithImpl<$Res, ExampleScreenSR>;
}

/// @nodoc
class _$ExampleScreenSRCopyWithImpl<$Res, $Val extends ExampleScreenSR>
    implements $ExampleScreenSRCopyWith<$Res> {
  _$ExampleScreenSRCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadFinishedImplCopyWith<$Res> {
  factory _$$LoadFinishedImplCopyWith(
          _$LoadFinishedImpl value, $Res Function(_$LoadFinishedImpl) then) =
      __$$LoadFinishedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadFinishedImplCopyWithImpl<$Res>
    extends _$ExampleScreenSRCopyWithImpl<$Res, _$LoadFinishedImpl>
    implements _$$LoadFinishedImplCopyWith<$Res> {
  __$$LoadFinishedImplCopyWithImpl(
      _$LoadFinishedImpl _value, $Res Function(_$LoadFinishedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadFinishedImpl implements LoadFinished {
  const _$LoadFinishedImpl();

  @override
  String toString() {
    return 'ExampleScreenSR.loadFinished()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadFinishedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFinished,
  }) {
    return loadFinished();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFinished,
  }) {
    return loadFinished?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFinished,
    required TResult orElse(),
  }) {
    if (loadFinished != null) {
      return loadFinished();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFinished value) loadFinished,
  }) {
    return loadFinished(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFinished value)? loadFinished,
  }) {
    return loadFinished?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFinished value)? loadFinished,
    required TResult orElse(),
  }) {
    if (loadFinished != null) {
      return loadFinished(this);
    }
    return orElse();
  }
}

abstract class LoadFinished implements ExampleScreenSR {
  const factory LoadFinished() = _$LoadFinishedImpl;
}
