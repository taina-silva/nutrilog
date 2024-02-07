import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/modules/day_log/presentation/pages/date_picker_page.dart';
import 'package:nutrilog/app/modules/physical_activities/physical_activities_module.dart';

class DayLogModule extends Module {
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => DatePickerPage(
        pathAfterSelectDate: args.data['pathAfterSelectDate'],
      ),
    ),
    ModuleRoute(
      '/physical-activity',
      module: PhysicalActivitiesModule(),
    ),
    ModuleRoute(
      '/nutrition',
      module: PhysicalActivitiesModule(),
    )
  ];
}
