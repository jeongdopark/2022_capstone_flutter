import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String _displayText = "";
  String get getDisplayText => _displayText;

  String _connectStatus = "False";
  String get getConnectStatus => _connectStatus;

  int _displayNumber = 0;
  int get getDisplayNumber => _displayNumber;

  void setDisplayNumber(int number) {
    _displayNumber = number;
    notifyListeners();
  }

  void setConnectStatus(String text) {
    _connectStatus = text;
    notifyListeners();
  }

  void setDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }
}
