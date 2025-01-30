import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginUser extends LoginEvent {
  final String email;
  final String password;

  LoginUser(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// class TogglePasswordVisibility extends LoginEvent {}