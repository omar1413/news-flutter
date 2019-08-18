import 'package:flutter/material.dart';
import '../blocs/stories_povider.dart';
import '../models/item_model.dart';
import '../widgets/loading_container.dart';
import '../widgets/refresh.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBlock bloc) {
    return StreamBuilder<List<int>>(
      stream: bloc.topIds,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return buildListView(bloc, snapshot.data);
      },
    );
  }

  buildListView(StoriesBlock bloc, List<int> data) {
    return Refresh(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          print(index);
          return FutureBuilder<ItemModel>(
            future: bloc.getItem(data[index]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return NewsListTile(item: snapshot.data);
              }
              return LoadingContainer();
            },
          );
        },
      ),
    );
  }
}
