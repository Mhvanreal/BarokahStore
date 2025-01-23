import 'package:barokah/Page/login/login_bloc.dart';
import 'package:barokah/Page/register/register_bloc.dart';
import 'package:barokah/screens/login_screen.dart';
import 'package:barokah/data/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'splash_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SplashBloc()..add(StartSplash()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoading) {
            EasyLoading.show(status: 'Loading .... ');
          } else if (state is SplashNavigateToLogin) {
            EasyLoading.dismiss();
            Navigator.pushReplacement(
            context,
           MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => LoginBloc(context.read<AppDatabase>()), // Ganti RegisterBloc ke LoginBloc
                child: LoginPage(),
              ),
            ),
          );
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Image.asset('images/bg.png'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

