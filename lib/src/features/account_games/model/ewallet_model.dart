class EwalletModel {
  int? id;
  String? nama;
  String? icon;

  EwalletModel({
    required this.id,
    required this.nama,
    required this.icon,
  });

  EwalletModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nama = json["nama"];
    icon = json["icon"];
  }

  static List<EwalletModel> fromApiResponseList(List<dynamic> jsonList) {
    return jsonList.map((json) => EwalletModel.fromJson(json)).toList();
  }
}
