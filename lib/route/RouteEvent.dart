
import 'package:equatable/equatable.dart';

abstract class RoutesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateToPage extends RoutesEvent {
  final String routeName;
  NavigateToPage(this.routeName);

  @override
  List<Object> get props => [routeName];
}
