import 'package:get_it/get_it.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/services/logger_service.dart';
import 'package:gh_battle_assistant/services/store_service.dart';
import 'package:gh_battle_assistant/services/util_service.dart';

GetIt di = GetIt.instance;

void setupDI() {
  //services
  di.registerSingleton<ImageService>(ImageService());
  di.registerSingleton<StoreService>(StoreService());
  di.registerSingleton<UtilService>(UtilService());
  di.registerSingleton<LoggerService>(LoggerService());
}
