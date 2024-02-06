import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/datasources/physical_activities_datasource.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/repositories/physical_activities_repository.dart';
import 'package:nutrilog/app/modules/physical_activities/presentation/pages/register_physical_activity_page.dart';
import 'package:nutrilog/app/modules/physical_activities/presentation/stores/physical_activities_store.dart';

class PhysicalActivitiesModule extends Module {
  @override
  List<Bind> binds = [
    Bind.factory<PhysicalActivitiesDatasource>((i) => PhysicalActivitiesDatasourceImpl(i.get())),
    Bind.factory<PhysicalActivitiesRepository>(
        (i) => PhysicalActivitiesRepositoryImpl(i.get(), i.get())),
    Bind.lazySingleton((i) => PhysicalActivitiesStore(i.get())),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const RegisterPhysicalActivityPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
