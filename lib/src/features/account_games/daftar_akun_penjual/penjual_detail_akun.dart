import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/features/account_games/model/akun_game_model.dart';
import 'package:jbag/src/features/account_games/penjual_crud/edit_akun_game.dart';
import 'package:jbag/src/features/account_games/daftar_akun_penjual/penjual_daftar_akun.dart';

class PenjualDetailAkun extends StatefulWidget {
  final AkunGameModel? akunGame;

  const PenjualDetailAkun({
    super.key,
    this.akunGame,
  });

  @override
  State<PenjualDetailAkun> createState() => _AkunDetailScreenState();
}

class _AkunDetailScreenState extends State<PenjualDetailAkun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.dark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: MyColors.dark,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: MyColors.dark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.akunGame!.judul!,
                style: const TextStyle(
                    color: MyColors.white,
                    fontSize: 32,
                    fontFamily: 'BebasNeue'),
              ),
              const SizedBox(height: 10),
              Container(
                height: 160,
                width: double.infinity,
                color: Colors.grey[800],
                child: Center(
                  child: Image.network(
                    '$baseUrl/${widget.akunGame!.gambar!}',
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                          'assets/logo/logo-splash.png');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Deskripsi Akun',
                style: TextStyle(
                    color: Colors.grey, fontSize: 20, fontFamily: 'BebasNeue'),
              ),
              const SizedBox(height: 10),
              Container(
                height: 320,
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey[800],
                child: TextFormField(
                  initialValue: widget.akunGame!.deskripsi!,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(color: MyColors.white),
                  decoration: InputDecoration(
                    hintText: 'Masukkan deskripsi',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[800],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.akunGame!.harga!.toString(),
                style: const TextStyle(color: MyColors.white, fontSize: 24),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                EditAkunGame(akunGame: widget.akunGame!)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: const Color(0xFFFFC639),
                      foregroundColor: MyColors.dark,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 5),
                        Text(
                          'Edit',
                          style: TextStyle(fontFamily: 'BebasNeue'),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final response = await http.delete(Uri.parse(
                            '$baseUrl/api/akungame/${widget.akunGame!.id!}'));
                        final responseBody = json.decode(response.body);
                        if (response.statusCode == 200) {
                          if (responseBody['sukses'] == false) {
                            throw Exception(responseBody['message']);
                          }

                          if (!context.mounted) {
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(responseBody['message'])),
                          );

                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PenjualDaftarAkun()),
                            );
                          });
                        } else {
                          throw Exception('Gagal menghapus akun game');
                        }
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
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: MyColors.tertiary,
                      foregroundColor: MyColors.dark,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 5),
                        Text('Hapus',
                            style: TextStyle(fontFamily: 'BebasNeue')),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
