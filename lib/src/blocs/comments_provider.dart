import 'package:flutter/material.dart';
import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final bloc;

  CommentsProvider({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        bloc = CommentsBloc(),
        super(key: key, child: child);

  static CommentsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentsProvider)
            as CommentsProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(CommentsProvider old) {
    return true;
  }
}
