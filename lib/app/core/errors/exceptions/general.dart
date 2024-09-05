import 'package:equatable/equatable.dart';

class GetGeneralPhysicalActivitiesException extends Equatable implements Exception {
  final String? message;

  const GetGeneralPhysicalActivitiesException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class GetGeneralNutritionsException extends Equatable implements Exception {
  final String? message;

  const GetGeneralNutritionsException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class RegisterNewPhysicalActivityException extends Equatable implements Exception {
  final String? message;

  const RegisterNewPhysicalActivityException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class RegisterNewNutritionException extends Equatable implements Exception {
  final String? message;

  const RegisterNewNutritionException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}
