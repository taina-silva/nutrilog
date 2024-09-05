import 'package:equatable/equatable.dart';

class GetUserHistoryException extends Equatable implements Exception {
  final String? message;

  const GetUserHistoryException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class RegisterPhysicalActivityException extends Equatable implements Exception {
  final String? message;

  const RegisterPhysicalActivityException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class RegisterNutritionException extends Equatable implements Exception {
  final String? message;

  const RegisterNutritionException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class UnregisterPhysicalActivityException extends Equatable implements Exception {
  final String? message;

  const UnregisterPhysicalActivityException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class UnregisterNutritionException extends Equatable implements Exception {
  final String? message;

  const UnregisterNutritionException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}
