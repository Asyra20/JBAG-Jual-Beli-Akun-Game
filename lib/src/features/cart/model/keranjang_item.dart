class KeranjangItem {
  String? judul;
  int? harga;
  String? usernamePenjual;
  bool? isSelected;

  KeranjangItem({
    required this.judul,
    required this.harga,
    required this.usernamePenjual,
    this.isSelected = true,
  });

  KeranjangItem.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    harga = json['harga'];
    usernamePenjual = json['usernamePenjual'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['judul'] = judul;
    data['harga'] = harga;
    data['usernamePenjual'] = usernamePenjual;
    data['isSelected'] = isSelected;
    
    return data;
  }
}
