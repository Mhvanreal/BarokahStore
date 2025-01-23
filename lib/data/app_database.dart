import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase.internal();
  factory AppDatabase() => instance;

  static Database? _database;
  AppDatabase.internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = await _getDbPath();
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<String> _getDbPath() async {
    return join(await getDatabasesPath(), 'app_database.db');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        password TEXT,
        pertanyaan TEXT,
        jawaban TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE barang (
        id_barang INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_barang TEXT,
        harga_jual INTEGER,
        harga_per_pax INTEGER,
        stok_biji INTEGER,
        stok_pax INTEGER,
        jumlah_per_pax INTEGER,
        tgl_exp TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE suplyer (
        id_sup INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_sup TEXT,
        no_telp TEXT,
        alamat TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE dtl_suply (
        id_sup INTEGER,
        id_barang INTEGER,
        reStok INTEGER,
        reStok_pax INTEGER,
        tgl_reStok TEXT,
        total_harga INTEGER,
        FOREIGN KEY (id_sup) REFERENCES suplyer (id_sup),
        FOREIGN KEY (id_barang) REFERENCES barang (id_barang)
      )
    ''');
    await db.execute('''
      CREATE TABLE pembeli (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE transaksi (
        id_trans INTEGER PRIMARY KEY AUTOINCREMENT,
        tgl TEXT,
        total_barang INTEGER,
        total_harga INTEGER,
        tunai INTEGER,
        sts_pembayaran TEXT,
        id_pembeli INTEGER,
        id_user INTEGER,
        FOREIGN KEY (id_pembeli) REFERENCES pembeli (id),
        FOREIGN KEY (id_user) REFERENCES user (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE detail_transaksi (
        id_trans INTEGER,
        id_barang INTEGER,
        qty INTEGER,
        total_harga INTEGER,
        FOREIGN KEY (id_trans) REFERENCES transaksi (id_trans),
        FOREIGN KEY (id_barang) REFERENCES barang (id_barang)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Logika migrasi tabel, jika ada
    }
  }
 

 ////////////////////// DELETE ALL /////////////////////
//   Future<void> deleteAllData() async {
//   final db = await database;
//   await db.execute('PRAGMA foreign_keys = OFF');
  
//   // Hapus semua data dari setiap tabel
//   await db.delete('detail_transaksi');
//   await db.delete('transaksi');
//   await db.delete('pembeli');
//   await db.delete('dtl_suply');
//   await db.delete('suplyer');
//   await db.delete('barang');
//   await db.delete('user');
  
//   // Aktifkan kembali foreign key constraints
//   await db.execute('PRAGMA foreign_keys = ON');
// }

// void clearDatabase() async {
//   final database = AppDatabase();
//   await database.deleteAllData();
//   print('Semua data berhasil dihapus!');
// }


/////////////////////////////////////////////////////////////////////////////////////

Future<Map<String, dynamic>?> getUser(String email, String password) async {
  final db = await database;
  final result = await db.query(
    'user',
    where: 'email = ? AND password = ?',
    whereArgs: [email, password],
  );
  return result.isNotEmpty ? result.first : null;
}


}
