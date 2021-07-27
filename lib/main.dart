import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/models/home_screen_model.dart';
import 'package:provider/provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/screens/home_screen.dart';

void main() {
  setupDI();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: di<HomeScreenModel>(),
      child: CupertinoApp(
        title: 'Gloomhaven Battle Assistant',
        theme: CupertinoThemeData(
          scaffoldBackgroundColor: Colors.white,
          // primaryColor: Colors.amberAccent,
          // scaffoldBackgroundColor: Colors.brown,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
