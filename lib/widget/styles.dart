import 'package:flutter/material.dart';

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 16.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}

Widget disableBuildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    enabled: false,
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 16.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xFF4CAF50),
    minimumSize: Size(100, 50),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ));
