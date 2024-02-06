import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/failures.dart';
import 'package:nutrilog/app/core/infra/datasources/user_datasource.dart';
import 'package:nutrilog/app/core/infra/models/register_nutrition_payload_model.dart';
import 'package:nutrilog/app/core/infra/models/register_physical_activity_payload_model.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> registerPhysicalActivity(
      DateTime date, RegisterPhysicalActivityPayloadModel payload);
  Future<Either<Failure, Unit>> registerNutrition(
      DateTime date, RegisterNutritionPayloadModel payload);
}

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _datasource;
  final LoggerService _loggerService;

  UserRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, Unit>> registerPhysicalActivity(
      DateTime date, RegisterPhysicalActivityPayloadModel payload) async {
    try {
      await _datasource.registerPhysicalActivityAtDate(date, payload);
      return const Right(unit);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> registerNutrition(
      DateTime date, RegisterNutritionPayloadModel payload) async {
    try {
      await _datasource.registerNutritionAtDate(date, payload);
      return const Right(unit);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
