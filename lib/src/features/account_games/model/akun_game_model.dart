class AkunGameModel {
  int? id;
  int? gameId;
  String? judul;
  String? deskripsi;
  int? harga;
  String? gambar;
  int? penjualId;
  String? usernamePenjual;

  AkunGameModel({
    required this.id,
    required this.gameId,
    required this.judul,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
    required this.penjualId,
    this.usernamePenjual,
  });

  AkunGameModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    gameId = json['game_id'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    harga = json['harga'];
    gambar = json['gambar'];
    penjualId = json['penjual_id'];
    if (json['penjual'] != null) {
      usernamePenjual = json['penjual']['user']['nama'];
    }
  }

  static List<AkunGameModel> fromApiResponseList(List<dynamic> jsonList) {
    return jsonList.map((json) => AkunGameModel.fromJson(json)).toList();
  }
}
