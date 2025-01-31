import 'package:equatable/equatable.dart';

abstract class RoutesState extends Equatable {
  @override
  List<Object> get props => [];
}

class RoutesInitial extends RoutesState {}

class NavigationState extends RoutesState {
  final String routeName;
  NavigationState(this.routeName);

  @override
  List<Object> get props => [routeName];
}
