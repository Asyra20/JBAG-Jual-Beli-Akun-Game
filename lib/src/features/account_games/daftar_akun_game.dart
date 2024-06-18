import 'package:flutter/material.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/auth/login_screen.dart';
import 'package:jbag/src/features/cart/keranjang_screen.dart';
import 'package:jbag/src/features/profile/pembeli/profil_pembeli_screen.dart';

class DaftarAkunGamesLayar extends StatefulWidget {
  const DaftarAkunGamesLayar({Key? key}) : super(key: key);

  @override
  _DaftarAkunGamesLayarState createState() => _DaftarAkunGamesLayarState();
}

class _DaftarAkunGamesLayarState extends State<DaftarAkunGamesLayar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

void _showLogoutConfirmationDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFECE8E1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "PEMBERITAHUAN",
                style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 24,
                  color: Color(0xFF131A2A),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "APAKAH ANDA INGIN LOGOUT?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 18,
                  color: Color(0xFF131A2A),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFC639),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "YES SIR!",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'BebasNeue',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF9564F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "NAH!",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'BebasNeue',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFFFAFF)),
        title: Text(
          'Daftar Akun Games',
          style: TextStyle(color: Color(0xFFFFFAFF)),
        ),
        backgroundColor: Color(0xFF131A2A),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF131A2A),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              Container(
                color: Color(0xFF131A2A),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Color(0xFFFFFAFF)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Profil', style: TextStyle(color: Color(0xFFFFFAFF))),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilPembeli()),
                  );
                },
              ),
              ListTile(
                title: const Text('Daftar Akun Games', style: TextStyle(color: Color(0xFFFFFAFF))),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Keranjang', style: TextStyle(color: Color(0xFFFFFAFF))),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KeranjangScreen()),
                  );
                },
              ),
              ListTile(
                title: const Text('Riwayat', style: TextStyle(color: Color(0xFFFFFAFF))),
                selected: _selectedIndex == 3,
                onTap: () {
                  _onItemTapped(3);
                  Navigator.pop(context);
                },
              ),
              Spacer(),
              ListTile(
                title: const Text('Report', style: TextStyle(color: Color(0xFFFFFAFF))),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Logout', style: TextStyle(color: Color(0xFFFFFAFF))),
                onTap: () {
                  _showLogoutConfirmationDialog();
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF131A2A),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFC639)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                dropdownColor: Color(0xFF131A2A),
                value: 'Mobile Legends',
                items: [
                  DropdownMenuItem(child: Text('Mobile Legends', style: TextStyle(color: Color(0xFFFFFAFF))), value: 'Mobile Legends'),
                  DropdownMenuItem(child: Text('Free Fire', style: TextStyle(color: Color(0xFFFFFAFF))), value: 'Free Fire'),
                ],
                onChanged: (value) {},
                iconEnabledColor: Color(0xFFFFFAFF),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF131A2A),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFC639)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Color(0xFFFFFAFF)),
                    onPressed: () {},
                  ),
                ),
                style: TextStyle(color: Color(0xFFFFFAFF)),
                cursorColor: MyColors.white,
              ),
              SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    KartuAkunGame(
                      imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSpSxJS6iDjzpWTViuc1VovCyBT8tCz7Q7FBhGDhP5O-FMXMcK5',
                      title: 'AKUN RAWAT PRIBADI SULTAN',
                      price: 'Rp 5.000.000',
                      logoUrl: 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoUjcDjDw_TMXthjcyBqcDzmvVEOFc1KZ3Zwuum3Bawyot5g8bXdILcAMF2Eb8MLYAJr1vscCS-fec8sIyqj_1tMTJ5KZjPwodKhXyqaEBcCNKwoUcpPNpM5wL68NXOHFto8cHaW3lrFBc/s2048/mlbb+old-01.png',
                    ),
                    SizedBox(height: 16),
                    KartuAkunGame(
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQSfrZ5oLUBB1CkW-IAxwa8oQJECoYK-JMNk-US5AgsG9ZXMM4',
                      title: 'AKUN PRO PLAYER SULTAN',
                      price: 'Rp 2.000.000',
                      logoUrl: 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoUjcDjDw_TMXthjcyBqcDzmvVEOFc1KZ3Zwuum3Bawyot5g8bXdILcAMF2Eb8MLYAJr1vscCS-fec8sIyqj_1tMTJ5KZjPwodKhXyqaEBcCNKwoUcpPNpM5wL68NXOHFto8cHaW3lrFBc/s2048/mlbb+old-01.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF131A2A),
    );
  }
}

class KartuAkunGame extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String logoUrl;

  KartuAkunGame({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xFFFFC639),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  color: Color(0xFF131A2A),
                  child: Text(
                    price,
                    style: TextStyle(
                      color: Color(0xFFFFFAFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  logoUrl,
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF131A2A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
