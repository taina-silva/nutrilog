import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/home/daily_history/presentation/stores/daily_history_store.dart';
import 'package:nutrilog/app/modules/home/new_log/presentation/pages/register_nutrition_page.dart';
import 'package:nutrilog/app/modules/home/new_log/presentation/pages/register_physical_activity_page.dart';

class DailyHistoryModule extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton((i) => DailyHistoryStore(i.get())),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/list-physical-activities',
      child: (_, args) => RegisterPhysicalActivityPage(
        date: args.data['date'],
      ),
    ),
    ChildRoute(
      '/list-nutritions',
      child: (_, args) => RegisterNutritionPage(
        date: args.data['date'],
      ),
    ),
  ];
}
