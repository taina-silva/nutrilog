import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/failures.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/modules/nutrition/infra/datasources/nutritions_datasource.dart';
import 'package:nutrilog/app/modules/nutrition/infra/models/nutrition_model.dart';
import 'package:nutrilog/app/modules/nutrition/infra/models/nutrition_type_model.dart';

abstract class NutritionsRepository {
  Future<Either<Failure, Tuple2<List<NutritionTypeModel>, List<NutritionModel>>>>
      getAllNutritions();
}

class NutritionsRepositoryImpl implements NutritionsRepository {
  final NutritionsDatasource _datasource;
  final LoggerService _loggerService;

  NutritionsRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, Tuple2<List<NutritionTypeModel>, List<NutritionModel>>>>
      getAllNutritions() async {
    try {
      Tuple2<List<NutritionTypeModel>, List<NutritionModel>> result =
          await _datasource.getAllNutritions();
      return Right(result);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
