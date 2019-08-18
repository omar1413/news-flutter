import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  final w = Container(
    height: 50.0,
    margin: EdgeInsets.all(15.0),
    child: Text(
      'hello',
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
  );

  final w2 = Container(
    height: 50.0,
    margin: EdgeInsets.all(15.0),
    child: Text(
      'loading',
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: buildList(),
      ),
    );
  }

  buildList() {
    var list = <Widget>[];
    for (int i = 0; i < 300; i++) {
      var f = FutureBuilder(
        future: fu(),
        builder: (context, sn) {
          print(sn.hasData);
          if (sn.hasData) {
            return w;
          }
          return w2;
        },
      );
      list.add(f);
    }
    return ListView(
      children: list,
    );
  }

  Future<int> fu() async {
    await Future.delayed(Duration(seconds: 6));
    return 1;
  }
}
