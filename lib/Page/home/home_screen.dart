import 'package:barokah/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Beranda")),
      body: 
     BlocConsumer<HomeBloc, HomeState>(
  listener: (context, state) {
    if (state is HomeSnackbar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    } else if (state is LogoutSuccess) {
      // Navigasi ke halaman login
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
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User ID: ${state.userId}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text("Name: ${state.userName}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Email: ${state.userEmail}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<HomeBloc>(context),
                    child: AlertDialog(
                      title: Text("Confirm Logout"),
                      content: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(ConfirmLogout());
                            Navigator.pop(context); // Tutup dialog
                          },
                          child: Text("Logout"),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text("Logout"),
            ),
          ],
        ),
      );
    } else if (state is HomeError) {
      return Center(child: Text(state.error));
    } else {
      return Center(child: Text("No data available."));
    }
  },
),
    );
  }
}
