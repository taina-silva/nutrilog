import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupErrorState extends SignupState {
  final String message;
  SignupErrorState(this.message);
}

abstract class SigninState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SigninInitialState extends SigninState {}

class SigninLoadingState extends SigninState {}

class SigninSuccessState extends SigninState {}

class SigninErrorState extends SigninState {
  final String message;
  SigninErrorState(this.message);
}

abstract class SignoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignoutInitialState extends SignoutState {}

class SignoutLoadingState extends SignoutState {}

class SignoutSuccessState extends SignoutState {}

class SignoutErrorState extends SignoutState {
  final String message;
  SignoutErrorState(this.message);
}
