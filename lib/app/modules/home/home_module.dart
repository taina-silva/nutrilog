import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/day_log/day_log_module.dart';
import 'package:nutrilog/app/modules/home/presentation/pages/home_page.dart';
import 'package:nutrilog/app/modules/nutritions/nutritions_module.dart';
import 'package:nutrilog/app/modules/physical_activities/physical_activities_module.dart';

class HomeModule extends Module {
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const HomePage(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/day-log',
      module: DayLogModule(),
    ),
    ModuleRoute(
      '/physical-activities',
      module: PhysicalActivitiesModule(),
    ),
    ModuleRoute(
      '/nutritions',
      module: NutritionsModule(),
    ),
  ];
}
