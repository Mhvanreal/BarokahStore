
import 'package:barokah/route/RouteEvent.dart';
import 'package:barokah/route/routestate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  RoutesBloc() : super(RoutesInitial()) {
    on<NavigateToPage>(_onNavigateTopage);
  }

  void _onNavigateTopage(NavigateToPage event, Emitter<RoutesState> emit) {
    emit(NavigationState(event.routeName));
  }
}