import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({@required this.itemId}) : assert(itemId != null);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail '),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return FutureBuilder<ItemModel>(
      future: bloc.fetchItem(itemId),
      builder: (context, sn) {
        if (sn.hasData) {
          return buildList(bloc, sn.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildList(CommentsBloc bloc, ItemModel item) {
    return ListView.builder(
      itemCount: item.descendants + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          //header
          return buildHeader(item);
        }

        return FutureBuilder<Map<ItemModel, int>>(
          future: bloc.fetchComment(),
          builder: (context, sn) {
            if (sn.hasData) {
              return Text('${sn.data.values.first}');
            }
            return Text('loading');
          },
        );
      },
    );
  }

  Widget buildHeader(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Comments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          )
        ],
      ),
    );
  }
}
