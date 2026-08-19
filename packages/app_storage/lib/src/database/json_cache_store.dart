import 'dart:convert';

import 'package:app_core/app_core.dart';
import 'package:app_storage/src/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'json_cache_store.g.dart';

/// API 응답 오프라인 캐시. TTL(maxAge)을 지원한다.
///
/// Repository의 네트워크 우선 + 캐시 폴백 패턴에서 사용한다:
///
/// ```dart
/// // 네트워크 성공 시 캐시 갱신
/// await _cache.put('posts', dtos.map((e) => e.toJson()).toList());
///
/// // 네트워크 실패 시 캐시 폴백
/// final cached = await _cache.get(
///   'posts',
///   decode: (json) => (json as List)
///       .map((e) => PostDto.fromJson(e as Map<String, dynamic>))
///       .toList(),
/// );
/// ```
class JsonCacheStore {
  const JsonCacheStore(this._db);

  final AppDatabase _db;

  /// [json]은 jsonEncode 가능한 값(Map/List/원시 타입)이어야 한다.
  Future<void> put(String key, Object? json) async {
    await _db.cacheEntries.insertOnConflictUpdate(
      CacheEntriesCompanion.insert(
        cacheKey: key,
        payload: jsonEncode(json),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// 캐시가 없거나 [maxAge]보다 오래됐으면 null을 반환한다.
  /// 저장된 payload가 손상되어 디코딩에 실패하면 [CacheException]을 던진다.
  Future<T?> get<T>(
    String key, {
    required T Function(Object? json) decode,
    Duration? maxAge,
  }) async {
    final row =
        await (_db.cacheEntries.select()..where((t) => t.cacheKey.equals(key)))
            .getSingleOrNull();
    if (row == null) return null;

    if (maxAge != null && DateTime.now().difference(row.updatedAt) > maxAge) {
      return null;
    }

    try {
      return decode(jsonDecode(row.payload));
    } catch (e, st) {
      throw CacheException(
        message: 'Failed to decode cached payload for key "$key"',
        cause: e,
        stackTrace: st,
      );
    }
  }

  Future<void> evict(String key) async {
    await (_db.cacheEntries.delete()..where((t) => t.cacheKey.equals(key)))
        .go();
  }
}

@Riverpod(keepAlive: true)
JsonCacheStore jsonCacheStore(Ref ref) =>
    JsonCacheStore(ref.watch(appDatabaseProvider));
