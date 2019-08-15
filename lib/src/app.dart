import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_povider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        home: NewsList(),
      ),
    );
  }
}
