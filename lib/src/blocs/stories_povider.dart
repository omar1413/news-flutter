import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBlock bloc;

  StoriesProvider({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        bloc = StoriesBlock(),
        super(key: key, child: child);

  static StoriesBlock of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(StoriesProvider old) {
    return true;
  }
}
