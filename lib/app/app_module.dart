import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrilog/app/core/infra/datasources/auth_datasource.dart';
import 'package:nutrilog/app/core/infra/repositories/auth_repository.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/services/local_storage/secure_storage.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/core/stores/auth_store.dart';
import 'package:nutrilog/app/modules/access/access_module.dart';
import 'package:nutrilog/app/modules/entry/entry_module.dart';
import 'package:nutrilog/app/modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Bind> binds = [
    // Firebase
    Bind.factory((i) => FirebaseFirestore.instance),
    Bind.factory((i) => FirebaseAuth.instance),

    // Storage
    Bind.factory((i) => const FlutterSecureStorage()),
    Bind.factory<LocalStorage>((i) => SecureStorage(i.get())),

    // Logger
    Bind.lazySingleton<LoggerService>((i) => CrashlyticsLogger(i.get())),

    // Access
    Bind.factory<AuthDatasource>((i) => FirebaseAuthDatasource(i.get(), i.get())),
    Bind.factory<AuthRepository>((i) => FirebaseAuthRepository(i.get(), i.get())),
    Bind.lazySingleton((i) => AuthStore(i.get(), i.get())),
  ];

  @override
  List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: SplashModule(),
    ),
    ModuleRoute(
      '/access',
      module: AccessModule(),
    ),
    ModuleRoute(
      '/entry',
      module: EntryModule(),
    ),
  ];
}
