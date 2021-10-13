import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/settings_dialog.dart';
import 'package:gh_battle_assistant/services/store_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  setupDI();
  late GameData rawData;

  try {
    final rawDataString =
        await rootBundle.loadString('assets/cfg/game-data.json');
    rawData = GameData.fromJson(jsonDecode(rawDataString));
    final data = await di<StoreService>().read();

    runApp(Application(
      data: jsonDecode(data),
      rawData: rawData,
    ));
  } on FormatException catch (_) {
    print('Raw data json is not valid');
  } on FileSystemException catch (_) {
    runApp(Application(
      data: null,
      rawData: rawData,
    ));
  }
}

class Application extends StatefulWidget {
  final Map<String, dynamic>? data;
  final GameData rawData;

  Application({
    required this.data,
    required this.rawData,
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
    di.registerSingleton<EnemiesRepository>(EnemiesRepository(widget.rawData));
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EnemiesBloc(di<EnemiesRepository>()),
          ),
          BlocProvider(
            lazy: false,
            create: (_) => SettingsBloc()..add(SettingsLoadE()),
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
      ),
    );
  }
}
