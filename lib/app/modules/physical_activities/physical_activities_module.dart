import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/physical_activities/presentation/pages/physical_activities_list_page.dart';

class PhysicalActivitiesModule extends Module {
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => PhysicalActivitiesListPage(
        date: args.data['date'],
        physicalActivities: args.data['physicalActivities'],
      ),
      transition: TransitionType.fadeIn,
    ),
  ];
}
