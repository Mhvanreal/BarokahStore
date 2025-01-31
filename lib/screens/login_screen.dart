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
        appBar: AppBar(title: Text(
          "Login Toko Barokah",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Berhasil! ID: ${state.userId}"),
              backgroundColor: Colors.green,),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red,),
            );
          }
        },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Image.asset(
                      'images/pp.png',
                      width: 250,
                      height: 250,
                    ),
                    SizedBox(height: 40,),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Masukan email anda",
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color.fromARGB(255, 242, 71, 9),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        )
                      ),
                      validator: (value) {
                        if (value!.isEmpty){
                          return "email harus di isi";
                        }
                        if (value!.contains('@')){
                          return "email tidak valid";
                        }
                        return null;
                      },
                    style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Masukan password anda",
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromARGB(255, 242, 71, 9),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                    ),
                    validator:(value) {
                      if(value!.isEmpty){
                        return "password harus anda isi";
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                  ),
                    SizedBox(height:20),
                    ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        context.read<LoginBloc>().add(LoginUser(email, password));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Login", style: TextStyle(fontSize: 17, color:Colors.white),),
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
