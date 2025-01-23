
import 'package:barokah/Page/home/home_event.dart';
import 'package:barokah/Page/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(HomeInitial()){
    on<Loadhome>(_onloadHome);
    on<LogoutUser>(_onlogoutUser);
    on<ConfirmLogout>(ConfirmLogoutya);
  }

  Future<void> _onloadHome(Loadhome event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try{
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final userName = prefs.getString('userName');
      final userEmail = prefs.getString('userEmail');

      if(userId != null && userName != null && userEmail != null){
        emit(Homeloaded(userId: userId, userName: userName, userEmail: userEmail));
      }else {
        emit(HomeError("user data not found"));
      }
    }catch (e){
      emit(HomeError("failed to load Akses"));
    }
  }

  Future<void> _onlogoutUser(LogoutUser event, Emitter<HomeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit(HomeInitial());
    } catch (e) {
      emit(HomeError("Failed to logout: ${e.toString()}"));
    }
  }

 
 Future<void> ConfirmLogoutya(ConfirmLogout event, Emitter<HomeState> emit) async {
  emit(HomeLoading());
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(LogoutSuccess()); // Emit state untuk navigasi
  } catch (e) {
    emit(HomeError("Failed to logout: ${e.toString()}"));
  }
}



}