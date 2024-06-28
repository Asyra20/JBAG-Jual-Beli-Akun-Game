class RiwayatPembelianModel {
  int? id;
  String? invoice;
  String? status;

  RiwayatPembelianModel({
    required this.id,
    required this.invoice,
    required this.status,
  });

  RiwayatPembelianModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    invoice = json['invoice'];
    status = json['status_pembayaran'];
  }

  static List<RiwayatPembelianModel> fromApiResponseList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => RiwayatPembelianModel.fromJson(json))
        .toList();
  }
}
