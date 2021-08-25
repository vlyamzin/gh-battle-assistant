import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/services/store_service.dart';
import 'package:provider/provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();

  try {
    final data = await di<StoreService>().read();
    runApp(Application(data: jsonDecode(data)));
  } on FileSystemException catch (_) {
    runApp(Application(data: null));
  }
}

class Application extends StatelessWidget {
  final Map<String, dynamic>? data;
  Application({required this.data});


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
          value: data != null ? HomeScreenProvider.fromJson(data!) : HomeScreenProvider.empty(),
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
