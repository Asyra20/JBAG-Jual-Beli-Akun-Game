import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/constants/api_constants.dart';

class AdminDetailGame extends StatefulWidget {
  final int id;
  final String nama;
  final String icon;
  const AdminDetailGame(
      {super.key, required this.id, required this.nama, required this.icon});

  @override
  State<AdminDetailGame> createState() => _AdminDetailGameState();
}

class _AdminDetailGameState extends State<AdminDetailGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark,
      appBar: AppBar(
        backgroundColor: MyColors.dark,
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: MyColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Detail Game',
          style: TextStyle(
            fontFamily: 'BebasNeue',
            color: MyColors.white,
            fontSize: 42,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: widget.nama,
                          labelStyle: TextStyle(color: MyColors.dark),
                          fillColor: MyColors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.network(
                      '$baseUrl/${widget.icon}',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.medium,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset('assets/logo/logo-splash.png');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
