import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/failures.dart';
import 'package:nutrilog/app/core/infra/datasources/user_datasource.dart';
import 'package:nutrilog/app/core/infra/models/day_log_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_for_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';

abstract class UserRepository {
  Future<Either<Failure, List<DayLogModel>?>> getDayLogList();
  Future<Either<Failure, Unit>> registerPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload);
  Future<Either<Failure, Unit>> registerNutrition(DateTime date, NutritionsForMealModel payload);
}

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _datasource;
  final LoggerService _loggerService;

  UserRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, List<DayLogModel>?>> getDayLogList() async {
    try {
      List<DayLogModel>? result = await _datasource.getDayLogList();
      return Right(result);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> registerPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
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
      DateTime date, NutritionsForMealModel payload) async {
    try {
      await _datasource.registerNutritionAtDate(date, payload);
      return const Right(unit);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
