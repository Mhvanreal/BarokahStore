import 'package:barokah/Page/home/home_bloc.dart';
import 'package:barokah/Page/home/home_event.dart';
import 'package:barokah/Page/splash_screen/SplashScreen.dart';
import 'package:barokah/data/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


// void main() {
//   runApp(
//     MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider(create: (context) => AppDatabase()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

void main() {
  runApp(
    BlocProvider(
      create: (context) => HomeBloc()..add(Loadhome()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Barokah',
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: EasyLoading.init(),
      home: SplashScreen(),
      
    );
  }
}
