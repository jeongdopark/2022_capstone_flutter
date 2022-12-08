import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String _displayText = "";
  String get getDisplayText => _displayText;

  String _connectStatus = "False";
  String get getConnectStatus => _connectStatus;

  String _blueConnectStatus = "False";
  String get getBlueConnectStatus => _blueConnectStatus;

  int _displayNumber = 0;
  int get getDisplayNumber => _displayNumber;

  int _countNumber = 0;
  int get getCountNumber => _countNumber;

  void setCountNumber(int number) {
    // 저작운동 횟수 측정
    _countNumber = number;
    notifyListeners();
  }

  void setDisplayNumber(int number) {
    _displayNumber = number;
    notifyListeners();
  }

  void setBlueConnectStatus(String text) {
    _blueConnectStatus = text;
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
