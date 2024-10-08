import 'package:flutter/material.dart';
import 'package:jbag/src/features/admin/ewallet/admin_daftar_ewallet.dart';
import 'package:jbag/src/features/admin/game/admin_daftar_game.dart';

import 'package:jbag/src/features/reuseable_component/reuseable_component.dart';

class AdminMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131A2A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  'ADMIN',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Color(0xFFFFFAFF),
                    fontSize: 48,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        text: "game",
                        color: const Color(0xFFFFC639),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AdminDaftarGame();
                            },
                          ),
                        ),
                      ),
                      MyButton(
                        text: "ewallet",
                        color: const Color(0xFFFFC639),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AdminDaftarEwallet();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Center(
                  child: MyButton(
                    text: "logout",
                    color: const Color(0xFFF9564F),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
