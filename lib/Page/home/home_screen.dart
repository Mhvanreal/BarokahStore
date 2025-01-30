import 'package:barokah/compenent/menu_card.dart';
import 'package:barokah/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      context.read<HomeBloc>().add(Loadhome());
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
        backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is LogoutSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Homeloaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('images/pp.png'),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.userName, 
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(state.userEmail, style: TextStyle(fontSize: 16, color: Colors.black54)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Informasi Akun", 
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Divider(),
                          Text("User ID: ${state.userId}"),
                          SizedBox(height: 8),
                          Text("Nama: ${state.userName}"),
                          SizedBox(height: 8),
                          Text("Email: ${state.userEmail}"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   MenuCard(
                    title: "Kasir",
                    icon: Icons.shopping_bag,
                    onTap: () {
                      print("Navigasi ke halaman Kasir");
                    },
                  ),
                  MenuCard(
                    title: "Barang",
                    icon: Icons.inventory_2,
                    onTap: () {
                      print("Navigasi ke halaman Stok");
                    },
                  ),
                  MenuCard(
                    title: "Kasbon",
                    icon: Icons.account_balance_wallet,
                    onTap: () {
                      print("Navigasi ke halaman Kasbon");
                    },
                     ),    
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuCard(
                      title: "Kasir",
                      icon: Icons.shopping_bag,
                      onTap: () {
                        print("Navigasi ke halaman Kasir");
                      },
                    ),
                    MenuCard(
                      title: "Barang",
                      icon: Icons.inventory_2,
                      onTap: () {
                        print("Navigasi ke halaman Stok");
                      },
                    ),
                    SizedBox(width: 115), // Memberikan jarak kosong agar sejajar dengan baris atas
                  ],
                ),

                  SizedBox(height: 40,),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<HomeBloc>(context),
                            child: AlertDialog(
                              title: Text("Konfirmasi Logout"),
                              content: Text("Apakah Anda yakin ingin keluar?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Batal"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<HomeBloc>().add(ConfirmLogout());
                                    Navigator.pop(context);
                                  },
                                  child: Text("Logout", style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.logout),
                      label: Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: Text("Tidak ada data."));
          }
        },
      ),
    );
  }
}
