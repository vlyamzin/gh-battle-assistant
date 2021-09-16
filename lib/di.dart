import 'package:get_it/get_it.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/services/store_service.dart';
import 'package:gh_battle_assistant/services/util_service.dart';

// TODO move this into settings json [aa10d985a1382bc461a8a169fa01629b]
String difficulty = '2';

GetIt di = GetIt.instance;

void setupDI() {
  //services
  di.registerSingleton<ImageService>(ImageService());
  di.registerSingleton<StoreService>(StoreService());
  di.registerSingleton<UtilService>(UtilService());
}
