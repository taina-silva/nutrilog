import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/home/infra/datasources/manage_general_nutritions_datasource.dart';
import 'package:nutrilog/app/modules/home/infra/datasources/manage_general_physical_activities_datasource.dart';
import 'package:nutrilog/app/modules/home/infra/datasources/user_history_datasource.dart';
import 'package:nutrilog/app/modules/home/infra/repositories/manage_general_nutritions_repository.dart';
import 'package:nutrilog/app/modules/home/infra/repositories/manage_general_physical_activities_repository.dart';
import 'package:nutrilog/app/modules/home/infra/repositories/user_history_repository.dart';
import 'package:nutrilog/app/modules/home/new_log/new_log_module.dart';
import 'package:nutrilog/app/modules/home/presentation/pages/home_page.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/manage_general_nutritions_store.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/manage_general_physical_activities_store.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/user_history_store.dart';

class HomeModule extends Module {
  @override
  List<Bind> binds = [
    // Physical Activites
    Bind.factory((i) => ManageGeneralPhysicalActivitiesDatasourceImpl(i.get())),
    Bind.factory((i) => ManageGeneralPhysicalActivitiesRepositoryImpl(i.get(), i.get())),
    Bind.lazySingleton((i) => ManageGeneralPhysicalActivitiesStore(i.get())),

    // Nutritions
    Bind.factory((i) => ManageGeneralNutritionsDatasourceImpl(i.get())),
    Bind.factory((i) => ManageGeneralNutritionsRepositoryImpl(i.get(), i.get())),
    Bind.lazySingleton((i) => ManageGeneralNutritionsStore(i.get())),

    // User History
    Bind.factory((i) => UserHistoryDatasourceImpl(i.get(), i.get())),
    Bind.factory((i) => UserHistoryRepositoryImpl(i.get(), i.get())),
    Bind.lazySingleton((i) => UserHistoryStore(i.get())),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const HomePage(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/new-log',
      module: NewLogModule(),
    ),
    // ModuleRoute(
    //   '/daily-history',
    //   module: DayLogModule(),
    // ),
  ];
}
