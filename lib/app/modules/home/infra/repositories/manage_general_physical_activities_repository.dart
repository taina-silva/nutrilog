import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/exceptions/general.dart';
import 'package:nutrilog/app/core/errors/failures/general.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_model.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/modules/home/infra/datasources/manage_general_physical_activities_datasource.dart';

abstract class ManageGeneralPhysicalActivitiesRepository {
  Future<Either<Failure, List<ListPhysicalActivitiesModel>>> getGeneralPhysicalActivities();
  Future<Either<Failure, Unit>> registerNewPhysicalActivity(PhysicalActivityModel pA);
}

class ManageGeneralPhysicalActivitiesRepositoryImpl
    implements ManageGeneralPhysicalActivitiesRepository {
  final ManageGeneralPhysicalActivitiesDatasource _datasource;
  final LoggerService _loggerService;

  ManageGeneralPhysicalActivitiesRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, List<ListPhysicalActivitiesModel>>> getGeneralPhysicalActivities() async {
    try {
      final result = await _datasource.getGeneralPhysicalActivities();
      return right(result);
    } on GetGeneralPhysicalActivitiesException {
      return left(const GetGeneralPhysicalActivitiesFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> registerNewPhysicalActivity(PhysicalActivityModel pA) async {
    try {
      await _datasource.registerNewPhysicalActivity(pA);
      return right(unit);
    } on RegisterNewPhysicalActivityException {
      return left(const RegisterNewPhysicalActitivyFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return left(const ServerFailure());
    }
  }
}
