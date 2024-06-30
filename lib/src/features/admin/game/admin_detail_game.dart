import 'package:flutter/material.dart';
import 'package:jbag/src/features/reuseable_component/reuseable_component.dart';

class AdminDetailGame extends StatelessWidget {
  const AdminDetailGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFF131A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF131A2A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'DAFTAR GAME',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Color(0xFFFFFAFF),
                    fontSize: 48,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildTextField('Nama'),
                    _buildTextField('Icon'),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyButton(
                          text: "Batal",
                          color: const Color(0xFFF9564F),
                          onPressed: () {},
                        ),
                        MyButton(
                          text: "Tambah",
                          color: const Color(0xFFFFC639),
                          onPressed: () {},
                        ),
                      ],
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

  Widget _buildTextField(String label, {bool isPhotoField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          fillColor: Color(0xFFFFFAFF),
          filled: true,
          suffixIcon:
              isPhotoField ? Icon(Icons.camera_alt, color: Colors.black) : null,
        ),
      ),
    );
  }
}