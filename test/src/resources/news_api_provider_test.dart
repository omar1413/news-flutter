import 'package:news/src/resources/news_api_provider.dart';
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  test('fetchTopIds return a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((req) async {
      final ids = [1, 2, 3, 4, 5];
      return Response(json.encode(ids), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4, 5]);
  });

  test('fetchItem return a item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((req) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(55);

    expect(item.id, 123);
  });
}
