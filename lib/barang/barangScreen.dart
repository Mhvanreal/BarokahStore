

import 'package:flutter/material.dart';

class Barangscreen extends StatelessWidget {
  const Barangscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Barang"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text("Halaman Data Barang"),
      ),
    );
  }
}
