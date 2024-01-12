import 'package:equatable/equatable.dart';

class AuthPayloadModel extends Equatable {
  final String email;
  final String password;

  const AuthPayloadModel({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  bool get stringify => true;
}
