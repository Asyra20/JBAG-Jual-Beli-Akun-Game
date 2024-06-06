import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/features/cart/model/keranjang_item.dart';
import 'package:jbag/src/utils/format/currency_format.dart';

class KeranjangScreen extends StatefulWidget {
  const KeranjangScreen({super.key});

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  List<KeranjangItem> itemKeranjang = [
    KeranjangItem(judul: 'AKUN RAWAT PRIBADI SULTAN', harga: 5000000),
    KeranjangItem(judul: 'AKUN PRO PLAYER SULTAN', harga: 2000000),
    KeranjangItem(judul: 'AKUN PRO PLAYER GG', harga: 1500000),
  ];
  int _selectedCount = 0;
  double _totalHarga = 0;

  @override
  void initState() {
    super.initState();
    _selectedCount = itemKeranjang.length;
    _totalHarga = hitungHarga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131A2A),
        leading: IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.bars,
            color: Color(0xFFFFFAFF),
          ),
        ),
      ),
      body: KeranjangBody(
        itemKeranjang: itemKeranjang,
        selectedCount: _selectedCount,
        onItemSelected: (int index) {
          setState(() {
            itemKeranjang[index].selectItem = !itemKeranjang[index].isSelected;
            if (itemKeranjang[index].isSelected) {
              _selectedCount++;
            } else {
              _selectedCount--;
            }

            _totalHarga = hitungHarga();
          });
        },
        onItemRemoved: (int index) {
          setState(() {
            if (itemKeranjang[index].isSelected) {
              _selectedCount--;
            }
            itemKeranjang.removeAt(index);
            _totalHarga = hitungHarga();
          });
        },
      ),
      bottomNavigationBar: KeranjangBottomNavigationBar(
        selectedCount: _selectedCount,
        totalHarga: _totalHarga,
        onCheckout: () {
          if (_selectedCount > 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$_selectedCount item dengan total ${CurrencyFormat.convert2Idr(_totalHarga, 2)}",
                ),
              ),
            );
          }
        },
      ),
    );
  }

  double hitungHarga() {
    double totalHarga = 0;
    for (var item in itemKeranjang) {
      if (item.isSelected) {
        totalHarga += item.harga;
      }
    }
    return totalHarga;
  }
}

class KeranjangBottomNavigationBar extends StatelessWidget {
  const KeranjangBottomNavigationBar({
    super.key,
    required int selectedCount,
    required double totalHarga,
    required this.onCheckout,
  })  : _selectedCount = selectedCount,
        _totalHarga = totalHarga;

  final int _selectedCount;
  final double _totalHarga;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                maxLines: 1,
                "$_selectedCount Item",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'LeagueGothic',
                  fontSize: 38,
                  color: Color(0xFFFFFAFF),
                ),
              ),
              Text(
                maxLines: 1,
                CurrencyFormat.convert2Idr(_totalHarga, 2),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 38,
                  color: Color(0xFFFFFAFF),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC639),
                foregroundColor: const Color(0xFF131A2A),
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 90),
                textStyle: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'BebasNeue',
                  color: Color(0xFF393E46),
                ),
              ),
              onPressed: onCheckout,
              child: const Text("Checkout"),
            ),
          )
        ],
      ),
    );
  }
}

class KeranjangBody extends StatelessWidget {
  const KeranjangBody({
    super.key,
    required this.itemKeranjang,
    required this.onItemSelected,
    required this.selectedCount,
    required this.onItemRemoved,
  });

  final List<KeranjangItem> itemKeranjang;
  final Function onItemSelected;
  final Function onItemRemoved;
  final int selectedCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Keranjang',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: 48,
              color: Color(0xFFFFFAFF),
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemKeranjang.length,
            itemBuilder: (context, index) {
              final item = itemKeranjang[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Container(
                  color: const Color(0xFFECE8E1),
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 32,
                        padding: const EdgeInsets.all(16.0),
                        icon: FaIcon(
                          item.isSelected
                              ? FontAwesomeIcons.solidSquareCheck
                              : FontAwesomeIcons.square,
                          color: const Color(0xFF131A2A),
                        ),
                        onPressed: () => onItemSelected(index),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 1,
                              item.judul,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'LeagueGothic',
                                fontSize: 24,
                                color: Color(0xFF393E46),
                              ),
                            ),
                            Text(
                              maxLines: 1,
                              CurrencyFormat.convert2Idr(item.harga, 2),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'BebasNeue',
                                fontSize: 32,
                                color: Color(0xFF131A2A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Material(
                          child: Ink(
                            decoration: const BoxDecoration(
                              color: Color(0xFFF9564F),
                            ),
                            child: InkWell(
                              highlightColor: Colors.white,
                              onTap: () => onItemRemoved(index),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 24),
                                child: FaIcon(
                                  size: 32,
                                  FontAwesomeIcons.solidTrashCan,
                                  color: Color(0xFF131A2A),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
