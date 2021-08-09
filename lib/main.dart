import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/models/home_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/screens/home_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<GameData>(
          create: (context) async {
            var string =
                await rootBundle.loadString('assets/cfg/game-data.json');
            return GameData.fromJson(jsonDecode(string));
          },
          lazy: false,
          initialData: GameData([]),
        ),
        ChangeNotifierProvider.value(
          value: di<HomeScreenProvider>(),
        ),
      ],
      child: CupertinoApp(
        title: 'Gloomhaven Battle Assistant',
        theme: CupertinoThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
