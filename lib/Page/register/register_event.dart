import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String pertanyaan;
  final String jawaban;

  RegisterUser({
    required this.name,
    required this.email,
    required this.password,
    required this.pertanyaan,
    required this.jawaban,
  });

  @override
  List<Object> get props => [name, email, password];
}
