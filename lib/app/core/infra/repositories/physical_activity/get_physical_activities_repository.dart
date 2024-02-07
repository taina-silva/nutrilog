import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/failures.dart';
import 'package:nutrilog/app/core/infra/datasources/physical_activity/get_physical_activities_datasource.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';

abstract class GetPhysicalActivityRepository {
  Future<Either<Failure, List<ListPhysicalActivitiesModel>>> getAllPhysicalActivities();
}

class GetPhysicalActivityRepositoryImpl implements GetPhysicalActivityRepository {
  final GetPhysicalActivityDatasource _datasource;
  final LoggerService _loggerService;

  GetPhysicalActivityRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, List<ListPhysicalActivitiesModel>>> getAllPhysicalActivities() async {
    try {
      List<ListPhysicalActivitiesModel> result = await _datasource.getAllPhysicalActivities();
      return Right(result);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
