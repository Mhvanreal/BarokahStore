import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];


}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String userId;

  LoginSuccess(this.userId);

  @override
  List<Object> get props => [userId];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}

// class LoginStateView extends LoginState {
//   final bool isPasswordVisible;

//   LoginStateView({this.isPasswordVisible = false});

//   LoginStateView copyWith({bool? isPasswordVisible}) {
//     return LoginStateView(
//       isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
//     );
//   }

//   @override
//   List<Object> get props => [isPasswordVisible];
// }
