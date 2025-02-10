import 'package:barokah/barang/data/model_barang.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BarangDatabase {
  static final BarangDatabase instance = BarangDatabase._init();
  static Database? _database;

  BarangDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(path, version: 2);
  }

  Future<int> insertBarang(Barang barang) async {
    final db = await instance.database;
    return await db.insert('barang', barang.toMap());
  }

  Future<List<Barang>> getAllBarang() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT barang.*, suplyer.nama_sup 
      FROM barang 
      JOIN suplyer ON barang.id_barang = suplyer.id_sup
    ''');
    return result.map((map) => Barang.fromMap(map)).toList();
  }

  Future<int> updateBarang(Barang barang) async {
    final db = await instance.database;
    return await db.update(
      'barang',
      barang.toMap(),
      where: 'id_barang = ?',
      whereArgs: [barang.id],
    );
  }

  Future<int> deleteBarang(int id) async {
    final db = await instance.database;
    return await db.delete(
      'barang',
      where: 'id_barang = ?',
      whereArgs: [id],
    );
  }
}
