class KeranjangItem {
  final String _judul;
  final int _harga;
  bool _isSelected;

  KeranjangItem({
    required String judul,
    required int harga,
    bool isSelected = true,
  })  : _judul = judul,
        _harga = harga,
        _isSelected = isSelected;

  String get judul => _judul;
  int get harga => _harga;
  bool get isSelected => _isSelected;

  set selectItem(bool isSelected) {
    _isSelected = isSelected;
  } 
}
