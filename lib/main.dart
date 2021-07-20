import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/router.dart';

void main() {
  setupDI();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Gloomhaven Battle Assistant',
      theme: CupertinoThemeData(),
      initialRoute: '/',
      onGenerateRoute: GHRouter.generateRoute,
    );
  }
}
