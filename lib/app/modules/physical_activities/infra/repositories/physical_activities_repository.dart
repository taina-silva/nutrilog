import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/failures.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/datasources/physical_activities_datasource.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_model.dart';

abstract class PhysicalActivitiesRepository {
  Future<Either<Failure, List<PhysicalActivitiesModel>>> getAllPhysicalActivities();
}

class PhysicalActivitiesRepositoryImpl implements PhysicalActivitiesRepository {
  final PhysicalActivitiesDatasource _datasource;
  final LoggerService _loggerService;

  PhysicalActivitiesRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, List<PhysicalActivitiesModel>>> getAllPhysicalActivities() async {
    try {
      List<PhysicalActivitiesModel> result = await _datasource.getAllPhysicalActivities();
      return Right(result);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
