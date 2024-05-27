import 'package:flutter/cupertino.dart';

import 'app.dart';

class TabItem {
  final GlobalKey<NavigatorState> key;
  int _index = 0;
  late Widget _page;

  TabItem({required Widget page, required this.key}) {
    _page = page;
  }

  void setIndex(int i) {
    _index = i;
  }

  int getIndex() => _index;

  Widget get page {
    return Visibility(
      visible: _index == AppState.currentTab,
      maintainState: true,
      child: Navigator(
        key: key,
        onGenerateRoute: (routeSettings) {
          return CupertinoPageRoute(builder: (_) => _page, settings: routeSettings);
        },
      ),
    );
  }
}
