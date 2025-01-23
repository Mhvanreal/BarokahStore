import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];

}

class Loadhome extends HomeEvent{}

class LogoutUser extends HomeEvent {}

class ConfirmLogout extends HomeEvent {}
