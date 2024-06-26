import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/day_log/day_log_module.dart';
import 'package:nutrilog/app/modules/nutritions/presentation/pages/nutrition_list_page.dart';

class NutritionsModule extends Module {
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => NutritionsListPage(
        date: args.data['date'],
      ),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/day-log',
      module: DayLogModule(),
    ),
  ];
}
