import 'package:flutter/material.dart';
import 'package:usdtopeso/widget/history.dart';

class HistoryProvider extends ChangeNotifier {
  List<Transaction> trans = [];

  addData(Transaction t) {
    trans.add(t);
    notifyListeners();
  }
}
