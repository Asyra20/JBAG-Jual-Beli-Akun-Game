import 'package:flutter/material.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/riwayat/daftar_akun_riwayat.dart';
import 'package:jbag/src/features/cart/keranjang_screen.dart';
import 'package:jbag/src/features/profile/pembeli/profil_pembeli_screen.dart';
import 'package:jbag/src/features/auth/auth_controller.dart';

class SidebarGamePembeli extends StatefulWidget {
  const SidebarGamePembeli({super.key});

  @override
  State<SidebarGamePembeli> createState() => _SidebarGamePembeliState();
}

class _SidebarGamePembeliState extends State<SidebarGamePembeli> {
  final AuthController _authController = AuthController();
  Future<void> _handleLogout() async {
    try {
      await _authController.logout(context);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Drawer(
      child: Container(
        color: MyColors.dark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 45),
            Container(
              color: MyColors.dark,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: MyColors.white,
                      size: 45,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Profil',
                style: TextStyle(
                  color: MyColors.white,
                  fontFamily: 'LeagueGothic',
                  fontSize: 35,
                ),
              ),
              selected: selectedIndex == 0,
              onTap: () {
                onItemTapped(0);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfilPembeli()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Daftar Akun Games',
                style: TextStyle(
                  color: MyColors.white,
                  fontFamily: 'LeagueGothic',
                  fontSize: 35,
                ),
              ),
              selected: selectedIndex == 1,
              onTap: () {
                onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Keranjang',
                style: TextStyle(
                  color: MyColors.white,
                  fontFamily: 'LeagueGothic',
                  fontSize: 35,
                ),
              ),
              selected: selectedIndex == 2,
              onTap: () {
                onItemTapped(2);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KeranjangScreen()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Riwayat',
                style: TextStyle(
                  color: MyColors.white,
                  fontFamily: 'LeagueGothic',
                  fontSize: 35,
                ),
              ),
              selected: selectedIndex == 3,
              onTap: () {
                onItemTapped(3);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DaftarAkunScreen()),
                );
              },
            ),
            const Spacer(),
            ListTile(
              title: const Text(
                'Report',
                style: TextStyle(
                  color: MyColors.white,
                  fontFamily: 'LeagueGothic',
                  fontSize: 35,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: MyColors.white,
                  fontFamily: 'LeagueGothic',
                  fontSize: 35,
                ),
              ),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "PEMBERITAHUAN",
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 24,
                    color: MyColors.dark,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "APAKAH ANDA INGIN LOGOUT?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 18,
                    color: MyColors.dark,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.accent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () async {
                        await _handleLogout();
                      },
                      child: const Text(
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
                        backgroundColor: const Color(0xFFF9564F),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "NAH!",
                        style: TextStyle(
                          color: MyColors.dark,
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
