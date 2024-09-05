import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/exceptions/auth.dart';
import 'package:nutrilog/app/core/errors/exceptions/user_history.dart';
import 'package:nutrilog/app/core/errors/failures/auth.dart';
import 'package:nutrilog/app/core/errors/failures/general.dart';
import 'package:nutrilog/app/core/errors/failures/user_history.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/modules/home/infra/datasources/user_history_datasource.dart';

abstract class UserHistoryRepository {
  Future<Either<Failure, List<DayLogModel>>> getHistory();
  Future<Either<Failure, Unit>> registerPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload);
  Future<Either<Failure, Unit>> registerNutrition(DateTime date, NutritionsByMealModel payload);
  Future<Either<Failure, Unit>> unregisterPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel pA);
  Future<Either<Failure, Unit>> unregisterNutrition(DateTime date, NutritionsByMealModel payload);
}

class UserHistoryRepositoryImpl implements UserHistoryRepository {
  final UserHistoryDatasource _datasource;
  final LoggerService _loggerService;

  UserHistoryRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, List<DayLogModel>>> getHistory() async {
    try {
      final history = await _datasource.getHistory();
      return right(history);
    } on NoPermissionsException catch (_) {
      return left(const NoPermissionsFailure());
    } on GetUserHistoryException catch (_) {
      return left(const GetUserHistoryFailure());
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
      return right(unit);
    } on NoPermissionsException catch (_) {
      return left(const NoPermissionsFailure());
    } on RegisterPhysicalActivityException catch (_) {
      return left(const RegisterPhysicalActivityFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> registerNutrition(
      DateTime date, NutritionsByMealModel payload) async {
    try {
      await _datasource.registerNutritionAtDate(date, payload);
      return right(unit);
    } on NoPermissionsException catch (_) {
      return left(const NoPermissionsFailure());
    } on RegisterNutritionException catch (_) {
      return left(const RegisterNutritionFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> unregisterPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel pA) async {
    try {
      await _datasource.unregisterPhysicalActivityAtDate(date, pA);
      return right(unit);
    } on NoPermissionsException catch (_) {
      return left(const NoPermissionsFailure());
    } on UnregisterPhysicalActivityException catch (_) {
      return left(const UnregisterPhysicalActivityFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> unregisterNutrition(
      DateTime date, NutritionsByMealModel payload) async {
    try {
      await _datasource.unregisterNutritionAtDate(date, payload);
      return right(unit);
    } on NoPermissionsException catch (_) {
      return left(const NoPermissionsFailure());
    } on UnregisterNutritionException catch (_) {
      return left(const UnregisterNutritionFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
