import 'package:barokah/data/app_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppDatabase database;

  LoginBloc(this.database) : super(LoginInitial()) {
    on<LoginUser>(_onLoginUser);
    // on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final user = await database.getUser(event.email, event.password);

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', user['id'].toString());
        await prefs.setString('userName', user['name']);
        await prefs.setString('userEmail', user['email']);

        emit(LoginSuccess(user['name'].toString()));
        print("Data saved: userId=${user['id']}, userName=${user['name']}, userEmail=${user['email']}");
      } else {
        emit(LoginFailure("Email atau password salah."));
      }
    } catch (e) {
      emit(LoginFailure("Terjadi kesalahan: ${e.toString()}"));
    }
  }
  
}
