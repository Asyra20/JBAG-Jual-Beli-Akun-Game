import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/colors.dart';

class AdminTambahEwallet extends StatelessWidget {
  const AdminTambahEwallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.dark,
      appBar: AppBar(
        backgroundColor: MyColors.dark,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: MyColors.white,
          ),
        ),
      ),
      body: const TambahEwalletBody(),
    );
  }
}

class TambahEwalletBody extends StatefulWidget {
  const TambahEwalletBody({super.key});

  @override
  State<TambahEwalletBody> createState() => _TambahEwalletBodyState();
}

class _TambahEwalletBodyState extends State<TambahEwalletBody> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
