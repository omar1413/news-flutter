import 'package:flutter/material.dart';
import '../blocs/stories_povider.dart';
import '../models/item_model.dart';

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
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return FutureBuilder<ItemModel>(
          future: bloc.getItem(data[index]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildListTile(snapshot.data);
            }
            return Container(height: 80, child: Text('hello'));
          },
        );
      },
    );
  }

  buildListTile(ItemModel item) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text('${item.score} Points'),
      trailing: Column(
        children: <Widget>[
          Icon(Icons.comment),
          Text('${item.descendants}'),
        ],
      ),
    );
  }
}
