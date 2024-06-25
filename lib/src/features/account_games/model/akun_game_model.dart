class AkunGameModel {
  int? id;
  int? penjualId;
  int? gameId;
  String? judul;
  String? deskripsi;
  int? harga;
  String? gambar;

  AkunGameModel({
    required this.id,
    required this.penjualId,
    required this.gameId,
    required this.judul,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
  });

  AkunGameModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    penjualId = json['penjual_id'];
    gameId = json['game_id'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    harga = json['harga'];
    gambar = json['gambar'];
  }

  static List<AkunGameModel> fromApiResponseList(List<dynamic> jsonList) {
    return jsonList.map((json) => AkunGameModel.fromJson(json)).toList();
  }
}
