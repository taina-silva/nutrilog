import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/services/local_storage/secure_storage.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/modules/entry/entry_module.dart';
import 'package:nutrilog/app/modules/splash/splash_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  List<Bind> binds = [
    // Storage
    AsyncBind<SharedPreferences>((i) async => SharedPreferences.getInstance()),
    Bind.factory((i) => const FlutterSecureStorage()),
    Bind.factory<LocalStorage>((i) => SecureStorage(i.get())),

    // Logger
    Bind.lazySingleton<LoggerService>((i) => CrashlyticsLogger(i.get())),
  ];

  @override
  List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: SplashModule(),
    ),
    /* ModuleRoute(
      '/access',
      module: AccessModule(),
    ), */
    ModuleRoute(
      '/entry',
      module: EntryModule(),
    ),
  ];
}
