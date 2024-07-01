import 'package:flutter/material.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/penjual/penjual_daftar_akun.dart';
import 'package:jbag/src/features/account_games/penjual/tambah_akun_game.dart';
import 'package:jbag/src/features/auth/login_screen.dart';
import 'package:jbag/src/features/profile/penjual/profil_penjual_screen.dart';
import 'package:jbag/src/features/transaction/penjual/penjual_transaksi_akun.dart';

class PenjualSidebar extends StatelessWidget {
  const PenjualSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: MyColors.dark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: MyColors.dark,
              child: IconButton(
                icon: const Icon(Icons.close, color: MyColors.white, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 32,
                        fontFamily: 'BebasNeue',
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilPenjual(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Daftar akun',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 32,
                        fontFamily: 'BebasNeue',
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PenjualDaftarAkun(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Tambah akun',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 32,
                        fontFamily: 'BebasNeue',
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TambahAkunGame(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Transaksi',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 32,
                        fontFamily: 'BebasNeue',
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PenjualTransaksiAkun(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: const Text(
                    'Report',
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: 32,
                      fontFamily: 'BebasNeue',
                    ),
                  ),
                  onTap: () {
                    // Navigate to Report page
                  },
                ),
                ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: 32,
                      fontFamily: 'BebasNeue',
                    ),
                  ),
                  onTap: () {
                    _showLogoutConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
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
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
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
}
