import 'news_api_provider.dart';
import 'news_db_provider.dart';
import 'source.dart';
import 'cache_source.dart';
import '../models/item_model.dart';
import 'api_source.dart';

class Repository {
  final apis = <ApiSource>[NewsApiProvider()];

  final caches = <CacheSource>[newsDbProvider];

  Future<List<int>> getTopIds(Source source) async {
    final topIds = await source.fetchTopIds();
    return topIds;
  }

  Future<List<int>> fetchTopIds() async {
    for (var cache in caches) {
      final topIds = await getTopIds(cache);
      if (topIds != null) {
        return topIds;
      }
    }

    for (var source in apis) {
      final topIds = await getTopIds(source);
      if (topIds != null) {
        // TODO: cache top ids
        return topIds;
      }
    }
    return null;
  }

  void cacheItem(ItemModel item) {
    for (var cache in caches) {
      cache.addItem(item);
    }
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;

    item = await getCachedItem(id);

    if (item != null) {
      return item;
    }

    item = await getItemFromApi(id);
    cacheItem(item);

    return item;
  }

  Future<ItemModel> getCachedItem(int id) async {
    for (var cache in caches) {
      final item = await cache.fetchItem(id);
      if (item != null) {
        return item;
      }
    }

    return null;
  }

  Future<ItemModel> getItemFromApi(int id) async {
    for (var api in apis) {
      final item = await api.fetchItem(id);

      if (item != null) {
        return item;
      }
    }
    return null;
  }

  Future<void> clear() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}
