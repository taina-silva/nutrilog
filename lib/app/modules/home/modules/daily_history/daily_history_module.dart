import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/home/modules/daily_history/presentation/pages/nutrition_list_page.dart';
import 'package:nutrilog/app/modules/home/modules/daily_history/presentation/pages/physical_activities_list_page.dart';
import 'package:nutrilog/app/modules/home/modules/daily_history/presentation/stores/daily_history_store.dart';

class DailyHistoryModule extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton((i) => DailyHistoryStore(i.get())),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/physical-activities',
      child: (_, args) => PhysicalActivitiesListPage(
        date: args.data['date'],
      ),
    ),
    ChildRoute(
      '/nutritions',
      child: (_, args) => NutritionsListPage(
        date: args.data['date'],
      ),
    ),
  ];
}
