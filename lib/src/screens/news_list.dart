import 'package:flutter/material.dart';
import '../blocs/stories_povider.dart';
import '../models/item_model.dart';
import '../widgets/loading_container.dart';
import '../widgets/refresh.dart';

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
                return buildListTile(snapshot.data);
              }
              return LoadingContainer();
            },
          );
        },
      ),
    );
  }

  buildListTile(ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} Points'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
