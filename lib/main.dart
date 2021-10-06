import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/controllers/settings_controller.dart';
import 'package:gh_battle_assistant/services/store_service.dart';
import 'package:provider/provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  late GameData rawData;
  final _settings = SettingsController();
  di.registerSingleton<SettingsController>(_settings);

  try {
    await _settings.loadSettings();
    final rawDataString =
        await rootBundle.loadString('assets/cfg/game-data.json');
    rawData = GameData.fromJson(jsonDecode(rawDataString));
    final data = await di<StoreService>().read();

    runApp(Application(
      data: jsonDecode(data),
      rawData: rawData,
      settingsController: _settings,
    ));
  } on FormatException catch (_) {
    print('Raw data json is not valid');
  } on FileSystemException catch (_) {
    runApp(Application(
      data: null,
      rawData: rawData,
      settingsController: _settings,
    ));
  }
}

class Application extends StatefulWidget {
  final Map<String, dynamic>? data;
  final GameData rawData;
  final SettingsController settingsController;

  Application({
    required this.data,
    required this.rawData,
    required this.settingsController,
  });

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late HomeScreenProvider _homeScreenProvider;

  @override
  void initState() {
    super.initState();
    if (widget.data != null)
      _homeScreenProvider = HomeScreenProvider.fromJson(widget.data!);
    else
      _homeScreenProvider = HomeScreenProvider.empty();
    di.registerSingleton<HomeScreenProvider>(_homeScreenProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GameData>.value(
          value: widget.rawData,
        ),
        ChangeNotifierProvider.value(
          value: _homeScreenProvider,
        ),
        ChangeNotifierProvider.value(
          value: widget.settingsController,
        ),
      ],
      child: CupertinoApp(
        title: 'Gloomhaven Battle Assistant',
        theme: CupertinoThemeData(
          brightness: Brightness.dark,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              color: Color(0xFF000000),
              fontSize: 17,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
