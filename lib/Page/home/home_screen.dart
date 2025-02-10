import 'package:barokah/barang/screens/barangScreen.dart';
import 'package:barokah/compenent/menu_card.dart';
import 'package:barokah/kasir/KasirScreen.dart';
import 'package:barokah/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
     listener: (context, state) {
        if (state is NavigationState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => state.page),
          ).then((_) {
            context.read<HomeBloc>().add(Loadhome());
          });
        }else if (state is LogoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
          );
        } else if (state is HomeSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Beranda", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.teal,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
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
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(state.userEmail,
                                  style: TextStyle(fontSize: 16, color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Informasi Akun",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                            context
                                .read<HomeBloc>()
                                .add(NavigateToPage(KasirPage()));
                          },
                        ),
                        MenuCard(
                          title: "Product",
                          icon: Icons.inventory_2,
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(NavigateToPage(Barangscreen()));
                          },
                        ),
                        MenuCard(
                          title: "Kasbon",
                          icon: Icons.account_balance_wallet,
                          onTap: () {
                            // Tambahkan navigasi ke halaman Kasbon di sini
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MenuCard(
                          title: "Suplayer",
                          icon: Icons.group,
                          onTap: () {
                            // Tambahkan navigasi ke halaman Suplayer di sini
                          },
                        ),
                        SizedBox(width: 115),
                      ],
                    ),
                    SizedBox(height: 40),
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
                                      context
                                          .read<HomeBloc>()
                                          .add(ConfirmLogout());
                                      Navigator.pop(context);
                                    },
                                    child: Text("Logout",
                                        style: TextStyle(color: Colors.red)),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
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
      ),
    );
  }
}
