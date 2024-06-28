class RiwayatPembelianModel {
  int? id;
  String? invoice;

  RiwayatPembelianModel({
    required this.id,
    required this.invoice,
  });

  RiwayatPembelianModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    invoice = json['invoice'];
  }

  static List<RiwayatPembelianModel> fromApiResponseList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => RiwayatPembelianModel.fromJson(json))
        .toList();
  }
}
