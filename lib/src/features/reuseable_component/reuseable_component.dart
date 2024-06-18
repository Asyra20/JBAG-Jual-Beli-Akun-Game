import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogoutConfirmed;

  LogoutDialog({required this.onLogoutConfirmed});

  @override
  Widget build(BuildContext context) {
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
                    onLogoutConfirmed();
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
  }
}

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomDrawer({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF131A2A),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45),
            Container(
              color: Color(0xFF131A2A),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Color(0xFFFFFAFF),
                      size: 45,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            _buildDrawerItem(
              text: 'Profil',
              index: 0,
              onTap: () {
                onItemTapped(0);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profil_pembeli');
              },
              isSelected: selectedIndex == 0,
            ),
            _buildDrawerItem(
              text: 'Daftar Akun Games',
              index: 1,
              onTap: () {
                onItemTapped(1);
                Navigator.pop(context);
              },
              isSelected: selectedIndex == 1,
            ),
            _buildDrawerItem(
              text: 'Keranjang',
              index: 2,
              onTap: () {
                onItemTapped(2);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/keranjang_screen');
              },
              isSelected: selectedIndex == 2,
            ),
            _buildDrawerItem(
              text: 'Riwayat',
              index: 3,
              onTap: () {
                onItemTapped(3);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/riwayat_screen');
              },
              isSelected: selectedIndex == 3,
            ),
            Spacer(),
            _buildDrawerItem(
              text: 'Report',
              index: 4,
              onTap: () {
                // Implementasi untuk Report jika diperlukan
              },
              isSelected: selectedIndex == 4,
            ),
            _buildDrawerItem(
              text: 'Logout',
              index: 5,
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LogoutDialog(
                      onLogoutConfirmed: () {
                        // Implementasi logout di sini
                        // Misalnya, reset state atau navigasi ke halaman login
                        Navigator.pushReplacementNamed(context,
                            '/login'); // Contoh navigasi ke halaman login
                      },
                    );
                  },
                );
              },
              isSelected: selectedIndex == 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String text,
    required int index,
    required Function onTap,
    required bool isSelected,
  }) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xFFFFFAFF),
          fontFamily: 'LeagueGothic',
          fontSize: 35,
        ),
      ),
      selected: isSelected,
      onTap: () => onTap(),
    );
  }
}

// Widget untuk Dropdown dan Search Bar
class DropdownAndSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            DropdownMenuItem(
              child: Text('Mobile Legends',
                  style: TextStyle(color: Color(0xFFFFFAFF))),
              value: 'Mobile Legends',
            ),
            DropdownMenuItem(
              child:
                  Text('Free Fire', style: TextStyle(color: Color(0xFFFFFAFF))),
              value: 'Free Fire',
            ),
          ],
          onChanged: (value) {
            // Implementasi logika ketika nilai dropdown berubah
          },
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
              onPressed: () {
                // Implementasi logika ketika tombol pencarian ditekan
              },
            ),
          ),
          style: TextStyle(color: Color(0xFFFFFAFF)),
          cursorColor: Colors.white,
        ),
      ],
    );
  }
}
