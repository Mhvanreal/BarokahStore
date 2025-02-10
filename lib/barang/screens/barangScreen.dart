import 'package:barokah/barang/bloc/barang_bloc.dart';
import 'package:barokah/barang/bloc/barang_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Barangscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Barang')),
      body: BlocBuilder<BarangBloc, BarangState>(
        builder: (context, state) {
          if (state is BarangLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BarangLoaded) {
            return ListView.builder(
              itemCount: state.barangList.length,
              itemBuilder: (context, index) {
                final barang = state.barangList[index];
                return ListTile(
                  title: Text(barang.namaBarang),
                  subtitle: Text('Supplier: ${barang.namaSup}'),
                );
              },
            );
          } else if (state is BarangError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Tidak ada data'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman tambah barang
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
