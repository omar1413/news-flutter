import 'package:flutter/material.dart';
import '../models/item_model.dart';

class NewsListTile extends StatelessWidget {
  final ItemModel item;

  NewsListTile({@required this.item}) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    return buildListTile(context);
  }

  buildListTile(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
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
