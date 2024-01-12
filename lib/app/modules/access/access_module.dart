import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/access/infra/datasources/auth_datasource.dart';
import 'package:nutrilog/app/modules/access/infra/repositories/auth_repository.dart';
import 'package:nutrilog/app/modules/access/presentation/stores/auth_store.dart';

class AccessModule extends Module {
  @override
  List<Bind> binds = [
    Bind.factory((i) => FirebaseAuthDatasource(i.get())),
    Bind.factory((i) => FirebaseAuthRepository(i.get(), i.get())),
    Bind.lazySingleton((i) => AuthStore(i.get())),
  ];

  @override
  List<ModularRoute> routes = [
    /*  ChildRoute(
      '/',
      child: (_, __) => const SplashPage(),
      transition: TransitionType.fadeIn,
    ), */
  ];
}
