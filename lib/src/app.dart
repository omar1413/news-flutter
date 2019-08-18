import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_details.dart';
import 'blocs/stories_povider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          return NewsDetails(
            itemId: itemId,
          );
        },
      );
    }
  }
}
