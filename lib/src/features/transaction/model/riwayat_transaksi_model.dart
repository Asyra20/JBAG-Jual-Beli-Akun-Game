class RiwayatTransaksiModel {
  int? id;
  String? invoice;
  String? status;

  RiwayatTransaksiModel({
    required this.id,
    required this.invoice,
    required this.status,
  });

  RiwayatTransaksiModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    invoice = json['invoice'];
    status = json['status_pembayaran'];
  }

  static List<RiwayatTransaksiModel> fromApiResponseList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => RiwayatTransaksiModel.fromJson(json))
        .toList();
  }
}
