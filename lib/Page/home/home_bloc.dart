import 'package:barokah/Page/home/home_event.dart';
import 'package:barokah/Page/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<Loadhome>(_onLoadHome);
    on<LogoutUser>(_onLogoutUser);
    on<ConfirmLogout>(_onConfirmLogout);
    on<NavigateToPage>(_onNavigateToPage);
  }

  Future<void> _onLoadHome(Loadhome event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      await Future.delayed(Duration(seconds: 1));
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final userName = prefs.getString('userName');
      final userEmail = prefs.getString('userEmail');

      if (userId != null && userName != null && userEmail != null) {
        emit(Homeloaded(
          userId: userId,
          userName: userName,
          userEmail: userEmail,
        ));
      } else {
        emit(HomeError("User data not found"));
      }
    } catch (e) {
      emit(HomeError("Failed to load data: ${e.toString()}"));
    }
  }

  Future<void> _onLogoutUser(LogoutUser event, Emitter<HomeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit(HomeInitial());
    } catch (e) {
      emit(HomeError("Failed to logout: ${e.toString()}"));
    }
  }

  Future<void> _onConfirmLogout(ConfirmLogout event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit(LogoutSuccess());
    } catch (e) {
      emit(HomeError("Failed to confirm logout: ${e.toString()}"));
    }
  }

  void _onNavigateToPage(NavigateToPage event, Emitter<HomeState> emit) {
    emit(NavigationState(event.page));
  }
}
