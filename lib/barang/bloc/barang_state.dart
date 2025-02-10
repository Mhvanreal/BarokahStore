import 'package:barokah/barang/data/model_barang.dart';

abstract class BarangState {}

class BarangInitial extends BarangState {}

class BarangLoading extends BarangState {}

class BarangLoaded extends BarangState {
  final List<Barang> barangList;
  BarangLoaded(this.barangList);
}

class BarangError extends BarangState {
  final String message;
  BarangError(this.message);
}
