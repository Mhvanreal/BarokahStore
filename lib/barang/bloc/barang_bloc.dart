import 'package:barokah/barang/data/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'barang_event.dart';
import 'barang_state.dart';

class BarangBloc extends Bloc<BarangEvent, BarangState> {
  final BarangDatabase database = BarangDatabase.instance;

  BarangBloc() : super(BarangInitial()) {
    on<Loadbarang>(_onLoadBarang);
    on<AddBarang>(_onAddBarang);
    on<UpdateBarang>(_onUpdateBarang);
    on<DeleteBarang>(_onDeleteBarang);
  }

  Future<void> _onLoadBarang(Loadbarang event, Emitter<BarangState> emit) async {
    emit(BarangLoading());
    try {
      final data = await database.getAllBarang();
      emit(BarangLoaded(data));
    } catch (e) {
      emit(BarangError(e.toString()));
    }
  }

  Future<void> _onAddBarang(AddBarang event, Emitter<BarangState> emit) async {
    await database.insertBarang(event.barang);
    add(Loadbarang());
  }

  Future<void> _onUpdateBarang(UpdateBarang event, Emitter<BarangState> emit) async {
    await database.updateBarang(event.barang);
    add(Loadbarang());
  }

  Future<void> _onDeleteBarang(DeleteBarang event, Emitter<BarangState> emit) async {
    await database.deleteBarang(event.id);
    add(Loadbarang());
  }
}
