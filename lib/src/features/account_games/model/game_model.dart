class GameModel {
  int? id;
  String? nama;
  String? icon;

  GameModel({
    required this.id,
    required this.nama,
    required this.icon,
  });

  GameModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nama = json["nama"];
    icon = json["icon"];
  }

  static List<GameModel> fromApiResponseList(List<dynamic> jsonList) {
    return jsonList.map((json) => GameModel.fromJson(json)).toList();
  }
}
