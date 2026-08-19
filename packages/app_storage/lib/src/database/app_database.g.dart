// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CacheEntriesTable extends CacheEntries
    with TableInfo<$CacheEntriesTable, CacheEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cacheKeyMeta = const VerificationMeta(
    'cacheKey',
  );
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
    'cache_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [cacheKey, payload, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CacheEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cache_key')) {
      context.handle(
        _cacheKeyMeta,
        cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cacheKey};
  @override
  CacheEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheEntry(
      cacheKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cache_key'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CacheEntriesTable createAlias(String alias) {
    return $CacheEntriesTable(attachedDatabase, alias);
  }
}

class CacheEntry extends DataClass implements Insertable<CacheEntry> {
  final String cacheKey;

  /// JSON 문자열 payload.
  final String payload;
  final DateTime updatedAt;
  const CacheEntry({
    required this.cacheKey,
    required this.payload,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cache_key'] = Variable<String>(cacheKey);
    map['payload'] = Variable<String>(payload);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CacheEntriesCompanion toCompanion(bool nullToAbsent) {
    return CacheEntriesCompanion(
      cacheKey: Value(cacheKey),
      payload: Value(payload),
      updatedAt: Value(updatedAt),
    );
  }

  factory CacheEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheEntry(
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      payload: serializer.fromJson<String>(json['payload']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cacheKey': serializer.toJson<String>(cacheKey),
      'payload': serializer.toJson<String>(payload),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CacheEntry copyWith({
    String? cacheKey,
    String? payload,
    DateTime? updatedAt,
  }) => CacheEntry(
    cacheKey: cacheKey ?? this.cacheKey,
    payload: payload ?? this.payload,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CacheEntry copyWithCompanion(CacheEntriesCompanion data) {
    return CacheEntry(
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      payload: data.payload.present ? data.payload.value : this.payload,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntry(')
          ..write('cacheKey: $cacheKey, ')
          ..write('payload: $payload, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cacheKey, payload, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheEntry &&
          other.cacheKey == this.cacheKey &&
          other.payload == this.payload &&
          other.updatedAt == this.updatedAt);
}

class CacheEntriesCompanion extends UpdateCompanion<CacheEntry> {
  final Value<String> cacheKey;
  final Value<String> payload;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CacheEntriesCompanion({
    this.cacheKey = const Value.absent(),
    this.payload = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CacheEntriesCompanion.insert({
    required String cacheKey,
    required String payload,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : cacheKey = Value(cacheKey),
       payload = Value(payload),
       updatedAt = Value(updatedAt);
  static Insertable<CacheEntry> custom({
    Expression<String>? cacheKey,
    Expression<String>? payload,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cacheKey != null) 'cache_key': cacheKey,
      if (payload != null) 'payload': payload,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CacheEntriesCompanion copyWith({
    Value<String>? cacheKey,
    Value<String>? payload,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CacheEntriesCompanion(
      cacheKey: cacheKey ?? this.cacheKey,
      payload: payload ?? this.payload,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntriesCompanion(')
          ..write('cacheKey: $cacheKey, ')
          ..write('payload: $payload, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CacheEntriesTable cacheEntries = $CacheEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cacheEntries];
}

typedef $$CacheEntriesTableCreateCompanionBuilder =
    CacheEntriesCompanion Function({
      required String cacheKey,
      required String payload,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CacheEntriesTableUpdateCompanionBuilder =
    CacheEntriesCompanion Function({
      Value<String> cacheKey,
      Value<String> payload,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CacheEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CacheEntriesTable> {
  $$CacheEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CacheEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CacheEntriesTable> {
  $$CacheEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CacheEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CacheEntriesTable> {
  $$CacheEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CacheEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CacheEntriesTable,
          CacheEntry,
          $$CacheEntriesTableFilterComposer,
          $$CacheEntriesTableOrderingComposer,
          $$CacheEntriesTableAnnotationComposer,
          $$CacheEntriesTableCreateCompanionBuilder,
          $$CacheEntriesTableUpdateCompanionBuilder,
          (
            CacheEntry,
            BaseReferences<_$AppDatabase, $CacheEntriesTable, CacheEntry>,
          ),
          CacheEntry,
          PrefetchHooks Function()
        > {
  $$CacheEntriesTableTableManager(_$AppDatabase db, $CacheEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CacheEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CacheEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CacheEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> cacheKey = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CacheEntriesCompanion(
                cacheKey: cacheKey,
                payload: payload,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String cacheKey,
                required String payload,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CacheEntriesCompanion.insert(
                cacheKey: cacheKey,
                payload: payload,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CacheEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CacheEntriesTable,
      CacheEntry,
      $$CacheEntriesTableFilterComposer,
      $$CacheEntriesTableOrderingComposer,
      $$CacheEntriesTableAnnotationComposer,
      $$CacheEntriesTableCreateCompanionBuilder,
      $$CacheEntriesTableUpdateCompanionBuilder,
      (
        CacheEntry,
        BaseReferences<_$AppDatabase, $CacheEntriesTable, CacheEntry>,
      ),
      CacheEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CacheEntriesTableTableManager get cacheEntries =>
      $$CacheEntriesTableTableManager(_db, _db.cacheEntries);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';
