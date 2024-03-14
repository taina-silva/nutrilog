import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/failures.dart';
import 'package:nutrilog/app/core/infra/datasources/user/user_datasource.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';

abstract class UserRepository {
  Future<Either<Failure, List<DayLogModel>?>> getDayLogList();
  Future<Either<Failure, Unit>> registerPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload);
  Future<Either<Failure, Unit>> registerNutrition(DateTime date, NutritionsOneMealModel payload);
  Future<Either<Failure, Unit>> unregisterPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload);
  Future<Either<Failure, Unit>> unregisterNutrition(
      DateTime date, MealType mealType, NutritionWithEnergyModel payload);
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
      DateTime date, NutritionsOneMealModel payload) async {
    try {
      await _datasource.registerNutritionAtDate(date, payload);
      return const Right(unit);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> unregisterPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
    try {
      await _datasource.unregisterPhysicalActivityAtDate(date, payload);
      return const Right(unit);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> unregisterNutrition(
      DateTime date, MealType mealType, NutritionWithEnergyModel payload) async {
    try {
      await _datasource.unregisterNutritionAtDate(date, mealType, payload);
      return const Right(unit);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
