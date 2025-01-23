class User {
  final String name;
  final String email;
  final String password;
  final String pertanyaan;
  final String jawaban;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.pertanyaan,
    required this.jawaban,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'pertanyaan': pertanyaan,
      'jawaban': jawaban,
    };
  }
}
