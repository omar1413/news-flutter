import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:collection';

class CommentsBloc {
  final _repository = Repository();
  Queue<Map<int, int>> stack;

  Future<ItemModel> fetchItem(int id) async {
    stack = Queue();
    final item = await _repository.fetchItem(id);
    item.kids.forEach((kid) => stack.addFirst({kid: 0}));
    return item;
  }

  Future<Map<ItemModel, int>> fetchComment() async {
    Map<int, int> commentId = {};
    ItemModel item;
    do {
      commentId = stack.removeLast();
      item = await _repository.fetchItem(commentId.keys.first);
    } while (item.deleted || item.dead);
    for (int i = item.kids.length - 1; i >= 0; i--) {
      stack.addLast({item.kids[i]: commentId.values.first + 1});
    }

    return {item: commentId.values.first};
  }
}
