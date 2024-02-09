import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/day_log/presentation/pages/register_nutrition_page.dart';
import 'package:nutrilog/app/modules/day_log/presentation/pages/register_physical_activity_page.dart';
import 'package:nutrilog/app/modules/day_log/presentation/stores/day_log_store.dart';

class DayLogModule extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton((i) => DayLogStore()),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/physical-activity',
      child: (_, args) => RegisterPhysicalActivityPage(
        date: args.data['date'],
      ),
    ),
    ChildRoute(
      '/nutrition',
      child: (_, args) => RegisterNutritionPage(
        date: args.data['date'],
      ),
    ),
  ];
}
