import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/entry/presentation/pages/entry_page.dart';
import 'package:nutrilog/app/modules/entry/presentation/stores/entry_store.dart';
import 'package:nutrilog/app/modules/home/home_module.dart';

class EntryModule extends Module {
  @override
  List<Bind<Object>> binds = [
    Bind.lazySingleton((i) => EntryStore()),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const EntryPage(),
      transition: TransitionType.fadeIn,
      children: [
        ModuleRoute(
          '/home',
          module: HomeModule(),
          transition: TransitionType.fadeIn,
        ),
        /*  ModuleRoute(
          '/notepad',
          module: NotepadModule(),
          transition: TransitionType.fadeIn,
        ), */
      ],
    ),
  ];
}
