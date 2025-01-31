import 'package:barokah/Page/home/home_bloc.dart';
import 'package:barokah/Page/home/home_event.dart';
import 'package:barokah/Page/splash_screen/SplashScreen.dart';
import 'package:barokah/barang/barangScreen.dart';
import 'package:barokah/data/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (_, db) => db.close(),
        ),
        BlocProvider(
          create: (context) => HomeBloc()..add(Loadhome()),
        ),
        
      ],
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

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Toko Barokah',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       builder: EasyLoading.init(),
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/dataBarang':
//           //   return MaterialPageRoute(builder: (_) => DataBarangPage());
//           // case '/transaksi':
//           //   return MaterialPageRoute(builder: (_) => TransaksiPage());
//           // case '/supplier':
//           //   return MaterialPageRoute(builder: (_) => SupplierPage());
//           default:
//             return MaterialPageRoute(builder: (_) => SplashScreen());
//         }
//       },
//       home: SplashScreen(),
//     );
//   }
// }


