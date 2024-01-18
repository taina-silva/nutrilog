import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/errors/exceptions.dart';
import 'package:nutrilog/app/core/errors/failures.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';
import 'package:nutrilog/app/core/infra/datasources/auth_datasource.dart';
import 'package:nutrilog/app/core/infra/models/auth_payload_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> signup(AuthPayloadModel payload);
  Future<Either<Failure, String?>> signin(AuthPayloadModel payload);
  Future<Either<Failure, Unit>> signout();
}

class FirebaseAuthRepository implements AuthRepository {
  final AuthDatasource _datasource;
  final LoggerService _loggerService;

  FirebaseAuthRepository(this._datasource, this._loggerService);

  @override
  Future<Either<Failure, Unit>> signup(AuthPayloadModel payload) async {
    try {
      await _datasource.signup(payload);
      return const Right(unit);
    } on EmailAlreadyInUseException {
      return const Left(EmailAlreadyInUseFailure());
    } on InvalidEmailException {
      return const Left(InvalidEmailFailure());
    } on WeakPasswordException {
      return const Left(WeakPasswordFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> signin(AuthPayloadModel payload) async {
    try {
      String? uid = await _datasource.signin(payload);
      return Right(uid);
    } on UserNotFoundException {
      return const Left(UserNotFoundFailure());
    } on InvalidLoginCredentialsException {
      return const Left(InvalidLoginCredentialsFailure());
    } on WrongPasswordException {
      return const Left(WrongPasswordFailure());
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signout() async {
    try {
      await _datasource.signout();
      return const Right(unit);
    } catch (exception, stackTrace) {
      _loggerService.recordError(exception, stackTrace);
      return const Left(ServerFailure());
    }
  }
}
