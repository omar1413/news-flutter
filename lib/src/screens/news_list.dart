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
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return FutureBuilder<ItemModel>(
              future: bloc.getItem(snapshot.data[index]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 80,
                    child: Text(snapshot.data.title),
                  );
                }
                return Container(height: 80, child: Text('hello'));
              },
            );
          },
        );
      },
    );
  }
}
