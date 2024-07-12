import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbag/src/constants/colors.dart';
import 'package:jbag/src/features/account_games/model/ewallet_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jbag/src/constants/api_constants.dart';
import 'package:jbag/src/features/admin/ewallet/admin_detail_ewallet.dart';
import 'package:jbag/src/features/admin/ewallet/admin_tambah_ewallet.dart';

class AdminDaftarEwallet extends StatefulWidget {
  const AdminDaftarEwallet({super.key});

  @override
  State<AdminDaftarEwallet> createState() => _AdminDaftarEwalletState();
}

class _AdminDaftarEwalletState extends State<AdminDaftarEwallet> {
  late Future<List<EwalletModel>> _futureEwallets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeEwallets();
  }

  void _initializeEwallets() async {
    try {
      _futureEwallets = getEwallets();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print('Error: $e');
      // Mengembalikan Future yang error agar tidak mengganggu eksekusi FutureBuilder atau pemanggilan lainnya
      _futureEwallets = Future.error(e);
    }
  }

  Future<List<EwalletModel>> getEwallets() async {
    final response = await http.get(Uri.parse('$apiEndPoint/ewallets/'));
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['success'] == false) {
        throw Exception(responseBody['message']);
      }
      final data = responseBody['data'];

      List<EwalletModel> ewallets = EwalletModel.fromApiResponseList(data);

      return ewallets;
    } else {
      throw Exception('Failed to load ewallets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF131A2A),
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: MyColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Daftar Ewallet',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'BebasNeue',
            color: Color(0xFFFFFAFF),
            fontSize: 42,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: FutureBuilder(
          future: _futureEwallets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(color: MyColors.white);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<EwalletModel> listEwallets = snapshot.data!;
              return ListView.builder(
                itemCount: listEwallets.length,
                itemBuilder: (BuildContext context, int index) {
                  EwalletModel ewallet = listEwallets[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    color: const Color(0xFFFFC639),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            ewallet.nama!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontFamily: 'BebasNeue',
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.edit, color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminDetailEwallet(
                              id: ewallet.id!,
                              nama: ewallet.nama!,
                              icon: ewallet.icon!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminTambahEwallet()),
          );
        },
        backgroundColor: MyColors.accent,
        child: Icon(Icons.add, color: MyColors.dark),
      ),
    );
  }
}
