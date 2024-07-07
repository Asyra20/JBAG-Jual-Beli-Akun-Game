class DetailTransaksiModel {
  int? idTransaksi;
  String? invoice;
  String? tanggalWaktu;
  String? penjual;
  String? emailPembeli;
  String? statusPembayaran;
  List<Akun>? akun;
  int? hargaTotal;
  PaymentMethod? paymentMethod;
  String? namaProfilEwallet;
  String? nomorEwallet;
  String? buktiPembayaran;

  DetailTransaksiModel({
    this.idTransaksi,
    this.invoice,
    this.tanggalWaktu,
    this.penjual,
    this.emailPembeli,
    this.statusPembayaran,
    this.akun,
    this.hargaTotal,
    this.paymentMethod,
    this.namaProfilEwallet,
    this.nomorEwallet,
    this.buktiPembayaran,
  });

  DetailTransaksiModel.fromJson(Map<String, dynamic> json) {
    idTransaksi = json['id'];
    invoice = json['invoice'];
    tanggalWaktu = json['tanggal_waktu'];
    penjual = json['penjual']['user']['nama'];
    emailPembeli = json['pembeli']['email'];
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
    buktiPembayaran = json['bukti_pembayaran'];
  }
}

class Akun {
  int? idDetailTransaksi;
  int? idAkunGame;
  String? judul;
  int? harga;

  Akun({
    this.judul,
    this.harga,
    this.idDetailTransaksi,
    this.idAkunGame,
  });

  Akun.fromJson(Map<String, dynamic> json) {
    idDetailTransaksi = json['id'];
    idAkunGame = json['akun_game_id'];
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
    icon = json['icon'];
  }
}
