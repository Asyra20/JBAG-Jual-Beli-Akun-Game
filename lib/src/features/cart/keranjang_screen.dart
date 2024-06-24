import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/cart/controller/keranjang_controller.dart';
import 'package:jbag/src/features/cart/model/keranjang_item.dart';
import 'package:jbag/src/features/checkout/checkout_screen.dart';
import 'package:jbag/src/utils/format/currency_format.dart';

class KeranjangScreen extends StatefulWidget {
  const KeranjangScreen({super.key});

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  final KeranjangController _keranjangController = KeranjangController();
  List<KeranjangItem> itemKeranjang = [];
  int userId = 2;

  int _selectedCount = 0;
  double _totalHarga = 0;

  late Future<void> _futureKeranjang;

  @override
  void initState() {
    super.initState();
    _futureKeranjang = _fetchKeranjang();
  }

  Future<void> _fetchKeranjang() async {
    final items = await _keranjangController.fetchKeranjang(userId);
    setState(() {
      itemKeranjang = items;
      _selectedCount = itemKeranjang.where((item) => item.isSelected!).length;
      _totalHarga = hitungHarga();
    });
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
      body: SingleChildScrollView(
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
            FutureBuilder(
              future: _futureKeranjang,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: MyColors.white));
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      '!Error',
                      // 'Error: ${snapshot.error}',
                      style: TextStyle(
                        fontFamily: 'LeagueGothic',
                        fontSize: 18,
                        color: Color(0xFFFFFAFF),
                      ),
                    ),
                  );
                }

                if (itemKeranjang.isEmpty) {
                  return const Center(
                    child: Text(
                      'Keranjang kosong',
                      style: TextStyle(
                        fontFamily: 'LeagueGothic',
                        fontSize: 18,
                        color: Color(0xFFFFFAFF),
                      ),
                    ),
                  );
                }

                return KeranjangBody(
                  itemKeranjang: itemKeranjang,
                  selectedCount: _selectedCount,
                  onItemSelected: (int index) {
                    setState(() {
                      itemKeranjang[index].isSelected =
                          !itemKeranjang[index].isSelected!;
                      if (itemKeranjang[index].isSelected!) {
                        _selectedCount++;
                      } else {
                        _selectedCount--;
                      }

                      _totalHarga = hitungHarga();
                    });
                  },
                  onItemRemoved: (int index) async {
                    try {
                      String delete = await _keranjangController
                          .deleteKeranjang(itemKeranjang[index].id!);

                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(delete)),
                      );
                      setState(() {
                        if (itemKeranjang[index].isSelected!) {
                          _selectedCount--;
                        }
                        itemKeranjang.removeAt(index);
                        _totalHarga = hitungHarga();

                        if (itemKeranjang.isEmpty) {
                          _futureKeranjang = Future.value();
                        }
                      });
                    } catch (e) {
                      final errorMessage =
                          e is Exception ? e.toString() : 'Error: $e';

                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: KeranjangBottomNavigationBar(
        selectedCount: _selectedCount,
        totalHarga: _totalHarga,
        onCheckout: () {
          if (_selectedCount > 0) {
            List<KeranjangItem> selectedItems =
                itemKeranjang.where((item) => item.isSelected!).toList();

            Set<int> uniqueIds =
                selectedItems.map((item) => item.idPenjual!).toSet();
            String groupedIdPenjual = uniqueIds.join(',');

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen(
                  groupedIdPenjual: groupedIdPenjual,
                  itemKeranjang: selectedItems,
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
      if (item.isSelected!) {
        totalHarga += item.harga!;
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
                disabledBackgroundColor:
                    const Color.fromARGB(255, 178, 139, 39),
                disabledForegroundColor: const Color(0xFF131A2A),
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
              onPressed: _selectedCount >= 1 ? onCheckout : null,
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
    Map<String, List<KeranjangItem>> grupPenjual = {};

    for (var item in itemKeranjang) {
      if (grupPenjual.containsKey(item.usernamePenjual)) {
        grupPenjual[item.usernamePenjual]!.add(item);
      } else {
        grupPenjual[item.usernamePenjual!] = [item];
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: grupPenjual.keys.length,
      itemBuilder: (context, penjualIndex) {
        final penjual = grupPenjual.keys.elementAt(penjualIndex);
        final itemPenjual = grupPenjual[penjual]!;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                penjual,
                style: const TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 28,
                  color: Color(0xFFFFFAFF),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemPenjual.length,
                itemBuilder: (context, itemIndex) {
                  final item = itemPenjual[itemIndex];
                  final globalIndex = itemKeranjang
                      .indexWhere((element) => element.id == item.id);

                  return KeranjangItemCard(
                    item: item,
                    onItemSelected: () => onItemSelected(globalIndex),
                    onItemRemoved: () => onItemRemoved(globalIndex),
                  );
                },
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}

class KeranjangItemCard extends StatefulWidget {
  const KeranjangItemCard({
    super.key,
    required this.item,
    required this.onItemSelected,
    required this.onItemRemoved,
  });

  final KeranjangItem item;
  final VoidCallback onItemSelected;
  final VoidCallback onItemRemoved;

  @override
  State<KeranjangItemCard> createState() => _KeranjangItemCardState();
}

class _KeranjangItemCardState extends State<KeranjangItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: const Color(0xFFECE8E1),
        child: Row(
          children: [
            IconButton(
              iconSize: 32,
              padding: const EdgeInsets.all(16.0),
              icon: FaIcon(
                widget.item.isSelected!
                    ? FontAwesomeIcons.solidSquareCheck
                    : FontAwesomeIcons.square,
                color: const Color(0xFF131A2A),
              ),
              onPressed: widget.onItemSelected,
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    widget.item.judul!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'LeagueGothic',
                      fontSize: 24,
                      color: Color(0xFF393E46),
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    CurrencyFormat.convert2Idr(widget.item.harga, 2),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: 32,
                      color: Color(0xFF393E46),
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
                    onTap: widget.onItemRemoved,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
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
  }
}
