import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/screens/home_screen.dart';

class NoMatchedRouteError extends Error {
  NoMatchedRouteError(this.route);
  final String? route;
  String toString() => 'No such route exists: $route';
}

class GHRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      default:
        throw NoMatchedRouteError(settings.name);
    }
  }
}

