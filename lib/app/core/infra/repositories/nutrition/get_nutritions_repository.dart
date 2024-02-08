import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/failures.dart';
import 'package:nutrilog/app/core/infra/datasources/nutrition/get_nutritions_datasource.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';

abstract class GetNutritionRepository {
  Future<Either<Failure, List<ListNutritionsModel>>> getAllNutritions();
}

class GetNutritionRepositoryImpl implements GetNutritionRepository {
  final GetNutritionDatasource _datasource;
  final LoggerService _loggerService;

  GetNutritionRepositoryImpl(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, List<ListNutritionsModel>>> getAllNutritions() async {
    try {
      List<ListNutritionsModel> result = await _datasource.getAllNutritions();
      return Right(result);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
