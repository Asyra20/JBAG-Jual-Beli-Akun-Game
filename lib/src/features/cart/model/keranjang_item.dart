class KeranjangItem {
  int? id;
  int? idAkunGame;
  String? judul;
  int? harga;
  int? idPenjual;
  String? usernamePenjual;
  bool? isSelected;

  KeranjangItem({
    required this.id,
    required this.idAkunGame,
    required this.judul,
    required this.harga,
    required this.idPenjual,
    required this.usernamePenjual,
    this.isSelected = true,
  });

  KeranjangItem.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    idAkunGame = json["akun_game_id"];
    judul = json['akun_game']['judul'];
    harga = json['akun_game']['harga'];
    idPenjual = json['akun_game']['penjual_id'];
    usernamePenjual = json['akun_game']['penjual']['user']['nama'];
    isSelected = true;
  }

  static List<KeranjangItem> fromApiResponseList(List<dynamic> jsonList) {
    return jsonList.map((json) => KeranjangItem.fromJson(json)).toList();
  }
}
