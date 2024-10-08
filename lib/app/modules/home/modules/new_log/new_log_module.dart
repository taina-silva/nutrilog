import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/pages/register_nutrition_page.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/pages/register_physical_activity_page.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/stores/new_log_store.dart';

class NewLogModule extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton((i) => NewLogStore(i.get())),
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
