import 'package:barokah/barang/data/model_barang.dart';

abstract class BarangEvent {}

class Loadbarang extends BarangEvent{}

class AddBarang extends BarangEvent {
  final Barang barang;
  AddBarang(this.barang);
}

class UpdateBarang extends BarangEvent{
  final Barang barang;
  UpdateBarang(this.barang);

}

class DeleteBarang extends BarangEvent{
  final int id;
  DeleteBarang(this.id);
}