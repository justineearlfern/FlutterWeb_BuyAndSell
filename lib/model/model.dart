import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<USDBNS> fetchUSDBNS() async {
  final response = await http.get(Uri.parse(
      'https://free.currconv.com/api/v7/convert?q=USD_PHP&compact=ultra&apiKey=042949eec2b918b5f5cd'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return USDBNS.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class USDBNS {
  final double usd;

  USDBNS({
    @required this.usd,
  });

  factory USDBNS.fromJson(Map<String, dynamic> json) {
    return USDBNS(
      usd: json['USD_PHP'],
    );
  }
}
