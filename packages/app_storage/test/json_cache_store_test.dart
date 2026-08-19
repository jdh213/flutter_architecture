import 'package:app_core/app_core.dart';
import 'package:app_storage/app_storage.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late JsonCacheStore store;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    store = JsonCacheStore(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('put/get 라운드트립', () async {
    await store.put('key', {'a': 1});

    final value = await store.get(
      'key',
      decode: (json) => (json! as Map<String, dynamic>)['a'] as int,
    );

    expect(value, 1);
  });

  test('없는 키는 null을 반환한다', () async {
    final value = await store.get('missing', decode: (json) => json);

    expect(value, isNull);
  });

  test('maxAge보다 오래된 캐시는 null을 반환한다', () async {
    await db.cacheEntries.insertOne(
      CacheEntriesCompanion.insert(
        cacheKey: 'stale',
        payload: '"old"',
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    );

    final value = await store.get(
      'stale',
      maxAge: const Duration(days: 1),
      decode: (json) => json,
    );

    expect(value, isNull);
  });

  test('손상된 payload는 CacheException을 던진다', () async {
    await db.cacheEntries.insertOne(
      CacheEntriesCompanion.insert(
        cacheKey: 'corrupt',
        payload: '{invalid json',
        updatedAt: DateTime.now(),
      ),
    );

    expect(
      () => store.get('corrupt', decode: (json) => json),
      throwsA(isA<CacheException>()),
    );
  });

  test('evict 후에는 null을 반환한다', () async {
    await store.put('key', [1, 2, 3]);
    await store.evict('key');

    final value = await store.get('key', decode: (json) => json);

    expect(value, isNull);
  });
}
