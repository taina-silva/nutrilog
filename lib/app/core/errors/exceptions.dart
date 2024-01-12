import 'package:equatable/equatable.dart';

class EmailAlreadyInUseException extends Equatable implements Exception {
  final String? message;

  const EmailAlreadyInUseException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class InvalidEmailException extends Equatable implements Exception {
  final String? message;

  const InvalidEmailException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class WeakPasswordException extends Equatable implements Exception {
  final String? message;

  const WeakPasswordException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class UserNotFoundException extends Equatable implements Exception {
  final String? message;

  const UserNotFoundException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class WrongPasswordException extends Equatable implements Exception {
  final String? message;

  const WrongPasswordException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}
