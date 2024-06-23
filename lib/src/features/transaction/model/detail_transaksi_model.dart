class DetailTransaksiModel {
  String? invoice;
  String? penjual;
  String? statusPembayaran;
  List<Akun>? akun;
  int? hargaTotal;
  PaymentMethod? paymentMethod;
  String? namaProfilEwallet;
  String? nomorEwallet;

  DetailTransaksiModel({
    this.invoice,
    this.penjual,
    this.statusPembayaran,
    this.akun,
    this.hargaTotal,
    this.paymentMethod,
    this.namaProfilEwallet,
    this.nomorEwallet,
  });

  DetailTransaksiModel.fromJson(Map<String, dynamic> json) {
    invoice = json['invoice'];
    penjual = json['penjual']['user']['nama'];
    statusPembayaran = json['status_pembayaran'];
    if (json['detail_transaksi'] != null) {
      akun = <Akun>[];
      json['detail_transaksi'].forEach((v) {
        akun!.add(Akun.fromJson(v));
      });
    }
    hargaTotal = json['harga_total'];
    paymentMethod = json['penjual']['ewallet'] != null
        ? PaymentMethod.fromJson(json['penjual']['ewallet'])
        : null;
    namaProfilEwallet = json['nama_profil_ewallet'];
    nomorEwallet = json['nomor_ewallet'];
  }
}

class Akun {
  String? judul;
  int? harga;

  Akun({this.judul, this.harga});

  Akun.fromJson(Map<String, dynamic> json) {
    judul = json['akun_game']['judul'];
    harga = json['akun_game']['harga'];
  }
}

class PaymentMethod {
  String? nama;
  String? icon;

  PaymentMethod({this.nama, this.icon});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    icon = json['image'];
  }
}
