import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/item_model.dart';

class StoriesBlock {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();

  Observable<List<int>> get topIds => _topIds.stream;

  Future<void> fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  Future<ItemModel> getItem(int id) async {
    return _repository.fetchItem(id);
  }

  Future<void> clear() {
    return _repository.clear();
  }

  dispose() {
    _topIds.close();
  }
}
