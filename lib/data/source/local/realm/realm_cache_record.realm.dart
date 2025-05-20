// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_cache_record.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmCacheRecord extends _RealmCacheRecord
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmCacheRecord(
    String compoundKey,
    String cacheKey,
    String group,
    String value,
    DateTime createdAt,
  ) {
    RealmObjectBase.set(this, 'compoundKey', compoundKey);
    RealmObjectBase.set(this, 'cacheKey', cacheKey);
    RealmObjectBase.set(this, 'group', group);
    RealmObjectBase.set(this, 'value', value);
    RealmObjectBase.set(this, 'createdAt', createdAt);
  }

  RealmCacheRecord._();

  @override
  String get compoundKey =>
      RealmObjectBase.get<String>(this, 'compoundKey') as String;
  @override
  set compoundKey(String value) =>
      RealmObjectBase.set(this, 'compoundKey', value);

  @override
  String get cacheKey =>
      RealmObjectBase.get<String>(this, 'cacheKey') as String;
  @override
  set cacheKey(String value) => RealmObjectBase.set(this, 'cacheKey', value);

  @override
  String get group => RealmObjectBase.get<String>(this, 'group') as String;
  @override
  set group(String value) => RealmObjectBase.set(this, 'group', value);

  @override
  String get value => RealmObjectBase.get<String>(this, 'value') as String;
  @override
  set value(String value) => RealmObjectBase.set(this, 'value', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  Stream<RealmObjectChanges<RealmCacheRecord>> get changes =>
      RealmObjectBase.getChanges<RealmCacheRecord>(this);

  @override
  Stream<RealmObjectChanges<RealmCacheRecord>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmCacheRecord>(this, keyPaths);

  @override
  RealmCacheRecord freeze() =>
      RealmObjectBase.freezeObject<RealmCacheRecord>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'compoundKey': compoundKey.toEJson(),
      'cacheKey': cacheKey.toEJson(),
      'group': group.toEJson(),
      'value': value.toEJson(),
      'createdAt': createdAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmCacheRecord value) => value.toEJson();
  static RealmCacheRecord _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'compoundKey': EJsonValue compoundKey,
        'cacheKey': EJsonValue cacheKey,
        'group': EJsonValue group,
        'value': EJsonValue value,
        'createdAt': EJsonValue createdAt,
      } =>
        RealmCacheRecord(
          fromEJson(compoundKey),
          fromEJson(cacheKey),
          fromEJson(group),
          fromEJson(value),
          fromEJson(createdAt),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmCacheRecord._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RealmCacheRecord, 'RealmCacheRecord', [
      SchemaProperty('compoundKey', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('cacheKey', RealmPropertyType.string),
      SchemaProperty('group', RealmPropertyType.string),
      SchemaProperty('value', RealmPropertyType.string),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
