class PaymentMethodPenjual {
  String? usernamePenjual;
  String? nama;
  String? image;

  PaymentMethodPenjual({
    required this.usernamePenjual,
    required this.nama,
    required this.image,
  });

  PaymentMethodPenjual.fromJson(Map<String, dynamic> json) {
    usernamePenjual = json['usernamePenjual'];
    nama = json['nama'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usernamePenjual'] = usernamePenjual;
    data['nama'] = nama;
    data['image'] = image;

    return data;
  }
}
