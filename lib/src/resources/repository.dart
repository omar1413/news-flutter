import 'news_api_provider.dart';
import 'news_db_provider.dart';
import 'source.dart';
import 'cache.dart';
import '../models/item_model.dart';

class Repository {
  final sources = <Source>[
    NewsApiProvider(),
    newsDbProvider,
  ];

  final caches = <Cache>[newsDbProvider];

  Future<List<int>> fetchTopIds() async {
    for (var source in sources) {
      final topIds = await source.fetchTopIds();
      if (topIds != null) {
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
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        cacheItem(item);
        break;
      }
    }

    return item;
  }
}
