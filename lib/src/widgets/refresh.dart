import 'package:flutter/material.dart';
import '../blocs/stories_povider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clear();
        await bloc.fetchTopIds();
      },
    );
  }
}
