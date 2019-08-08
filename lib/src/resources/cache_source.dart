import '../models/item_model.dart';
import 'source.dart';

abstract class CacheSource implements Source {
  Future<int> addItem(ItemModel item);
}
