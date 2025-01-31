import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial state
class HomeInitial extends HomeState {}

// Loading state
class HomeLoading extends HomeState {}

// Loaded state with user data
class Homeloaded extends HomeState {
  final String userId;
  final String userName;
  final String userEmail;

  Homeloaded({
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

  @override
  List<Object> get props => [userId, userName, userEmail];
}

// Error state
class HomeError extends HomeState {
  final String error;

  HomeError(this.error);

  @override
  List<Object> get props => [error];
}

// Logout success state
class LogoutSuccess extends HomeState {}

// Snackbar state
class HomeSnackbar extends HomeState {
  final String message;

  HomeSnackbar(this.message);

  @override
  List<Object> get props => [message];
}

// Navigation state
class NavigationState extends HomeState {
  final Widget page;

  NavigationState(this.page);

  @override
  List<Object> get props => [page];
}
