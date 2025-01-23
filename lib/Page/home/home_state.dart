
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable{
  @override
  List<Object> get props => [];

}

class HomeInitial extends HomeState{}
class HomeLoading extends HomeState{}

class Homeloaded extends HomeState{
  final String userId;
  final String userName;
  final String userEmail;

  Homeloaded({required this.userId, required this.userEmail, required this.userName});
  @override
  List<Object> get props => [userId, userName, userEmail];
}

class HomeError extends HomeState{
  final String error;
  HomeError(this.error);
  @override
  List<Object> get props => [error];
}

class LogoutSuccess extends HomeState {}

class HomeSnackbar extends HomeState {
  final String message;

  HomeSnackbar(this.message);
}