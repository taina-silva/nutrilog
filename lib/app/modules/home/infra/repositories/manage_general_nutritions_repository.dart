import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/exceptions/general.dart';
import 'package:nutrilog/app/core/errors/failures/general.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/modules/home/infra/datasources/manage_general_nutritions_datasource.dart';

abstract class ManageGeneralNutritionsRepository {
  Future<Either<Failure, List<ListNutritionsModel>>> getGeneralNutritions();
  Future<Either<Failure, Unit>> registerNewNutrition(NutritionModel nutrition);
}

class ManageGeneralNutritionsRepositoryImpl implements ManageGeneralNutritionsRepository {
  final ManageGeneralNutritionsDatasource _datasource;
  final LoggerService _loggerService;

  ManageGeneralNutritionsRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, List<ListNutritionsModel>>> getGeneralNutritions() async {
    try {
      final result = await _datasource.getGeneralNutritions();
      return right(result);
    } on GetGeneralNutritionsException {
      return left(const GetGeneralNutritionsFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> registerNewNutrition(NutritionModel nutrition) async {
    try {
      await _datasource.registerNewNutrition(nutrition);
      return right(unit);
    } on RegisterNewNutritionException {
      return left(const RegisterNewNutritionFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return left(const ServerFailure());
    }
  }
}
