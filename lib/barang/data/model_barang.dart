class Barang {
  int? id;
  String namaBarang;
  int hargaJual;
  int hargaPerPax;
  int stokBiji;
  int stokPax;
  int jumlahPerPax;
  String tglExp;
  
  String namaSup; // Relasi dengan tabel suplyer

  Barang({
    this.id,
    required this.namaBarang,
    required this.hargaJual,
    required this.hargaPerPax,
    required this.stokBiji,
    required this.stokPax,
    required this.jumlahPerPax,
    required this.tglExp,
    required this.namaSup,
  });

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id_barang'],
      namaBarang: map['nama_barang'],
      hargaJual: map['harga_jual'],
      hargaPerPax: map['harga_per_pax'],
      stokBiji: map['stok_biji'],
      stokPax: map['stok_pax'],
      jumlahPerPax: map['jumlah_per_pax'],
      tglExp: map['tgl_exp'],
      namaSup: map['nama_sup'], // Join dengan tabel suplyer
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_barang': id,
      'nama_barang': namaBarang,
      'harga_jual': hargaJual,
      'harga_per_pax': hargaPerPax,
      'stok_biji': stokBiji,
      'stok_pax': stokPax,
      'jumlah_per_pax': jumlahPerPax,
      'tgl_exp': tglExp,
    };
  }
}
