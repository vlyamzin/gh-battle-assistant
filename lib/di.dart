import 'package:get_it/get_it.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/services/store_service.dart';

// TODO move this into settings json
String difficulty = '2';

GetIt di = GetIt.instance;

void setupDI() {
  //services
  di.registerSingleton<ImageService>(ImageService());
  di.registerSingleton<StoreService>(StoreService());
}
