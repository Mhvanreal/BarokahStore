import 'package:barokah/Page/home/home_screen.dart';
import 'package:barokah/Page/login/login_bloc.dart';
import 'package:barokah/Page/login/login_event.dart';
import 'package:barokah/Page/login/login_state.dart';
import 'package:barokah/Page/profile/profile_screen.dart';
import 'package:barokah/Page/register/register_bloc.dart';
import 'package:barokah/data/app_database.dart';
import 'package:barokah/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AppDatabase()),
      child: Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Berhasil! ID: ${state.userId}")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: "Email"),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        context.read<LoginBloc>().add(LoginUser(email, password));
                      },
                      child: Text("Login"),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => RegisterBloc(database: context.read<AppDatabase>()),
                            child: RegisterScreen(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Belum punya akun? Daftar di sini",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
