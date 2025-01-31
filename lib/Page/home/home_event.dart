import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Event to load home data
class Loadhome extends HomeEvent {}

// Event to logout user
class LogoutUser extends HomeEvent {}

// Event to confirm logout
class ConfirmLogout extends HomeEvent {}

// Event to show a snackbar with a message
class ShowLoginSuccessPopup extends HomeEvent {
  final String message;

  ShowLoginSuccessPopup(this.message);

  @override
  List<Object> get props => [message];
}

// Event to navigate to a specific page
class NavigateToPage extends HomeEvent {
  final Widget page;

  NavigateToPage(this.page);

  @override
  List<Object> get props => [page];
}
