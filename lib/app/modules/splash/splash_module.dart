import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:nutrilog/app/modules/splash/presentation/stores/splash_store.dart';

class SplashModule extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton((i) => SplashStore(i.get(), i.get())),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const SplashPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
