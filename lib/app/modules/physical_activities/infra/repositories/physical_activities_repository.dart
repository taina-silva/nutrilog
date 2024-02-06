import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/failures.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/datasources/physical_activities_datasource.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_model.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_type_model.dart';

abstract class PhysicalActivitiesRepository {
  Future<Either<Failure, Tuple2<List<PhysicalActivityTypeModel>, List<PhysicalActivityModel>>>>
      getAllPhysicalActivities();
}

class PhysicalActivitiesRepositoryImpl implements PhysicalActivitiesRepository {
  final PhysicalActivitiesDatasource _datasource;
  final LoggerService _loggerService;

  PhysicalActivitiesRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, Tuple2<List<PhysicalActivityTypeModel>, List<PhysicalActivityModel>>>>
      getAllPhysicalActivities() async {
    try {
      Tuple2<List<PhysicalActivityTypeModel>, List<PhysicalActivityModel>> result =
          await _datasource.getAllPhysicalActivities();
      return Right(result);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
