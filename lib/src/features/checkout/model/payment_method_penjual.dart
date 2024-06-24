class PaymentMethodPenjual {
  int? idPenjual;
  String? usernamePenjual;
  String? nama;
  String? image;

  PaymentMethodPenjual({
    this.idPenjual,
    this.usernamePenjual,
    this.nama,
    this.image,
  });

  PaymentMethodPenjual.fromJson(Map<String, dynamic> json) {
    idPenjual = json['id'];
    usernamePenjual = json['user']['nama'];
    nama = json['ewallet']['nama'];
    image = json['ewallet']['icon'];
  }

  static List<PaymentMethodPenjual> fromApiResponseList(
      List<dynamic> jsonList) {
    return jsonList.map((json) => PaymentMethodPenjual.fromJson(json)).toList();
  }
}
