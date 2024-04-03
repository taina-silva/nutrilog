import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/graphics/presentation/graphics_page.dart';

class GraphicsModule extends Module {
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const GraphicsPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
