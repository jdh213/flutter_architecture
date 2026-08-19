import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

/// 범용 JSON 캐시 테이블.
///
/// feature별 전용 테이블 없이도 API 응답을 오프라인 캐시할 수 있도록
/// key-payload 구조를 사용한다. 정교한 쿼리가 필요한 feature는
/// 이 파일에 전용 테이블을 추가하고 schemaVersion을 올린 뒤
/// 마이그레이션을 작성한다.
class CacheEntries extends Table {
  TextColumn get cacheKey => text()();

  /// JSON 문자열 payload.
  TextColumn get payload => text()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {cacheKey};
}

@DriftDatabase(tables: [CacheEntries])
class AppDatabase extends _$AppDatabase {
  /// 테스트에서는 `AppDatabase(NativeDatabase.memory())`로 생성한다.
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'app_database'));

  @override
  int get schemaVersion => 1;
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
