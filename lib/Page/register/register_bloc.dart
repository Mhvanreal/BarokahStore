import 'package:barokah/data/app_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AppDatabase database;

  RegisterBloc({required this.database}) : super(RegisterInitial()) {
      on<RegisterUser>((event, emit) async {
      emit(RegisterLoading());

      try {
        final db = await database.database;
        final userData = {
          'name': event.name,
          'email': event.email,
          'password': event.password,
          'pertanyaan': event.pertanyaan,
          'jawaban': event.jawaban,
        };

        // Cek jika email sudah terdaftar
        final List<Map<String, dynamic>> existingUsers = await db.query(
          'user',
          where: 'email = ?',
          whereArgs: [event.email],
        );
        if (existingUsers.isNotEmpty) {
          emit(RegisterFailure('Email already exists!'));
        } else {
          await db.insert('user', userData);
          emit(RegisterSuccess());
        }
      } catch (e) {
        emit(RegisterFailure('Failed to register user: $e'));
      }
    });
  }
}
