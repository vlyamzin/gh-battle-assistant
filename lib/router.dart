import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/screens/add_unit_screen.dart';
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
      case 'add-unit':
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => AddUnitScreen()
        );
      default:
        return CupertinoPageRoute(builder: (_) {
          return CupertinoPageScaffold(
            child: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

