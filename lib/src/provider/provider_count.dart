import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String _displayText = "";
  String get getDisplayText => _displayText;

  String _connectStatus = "False";
  String get getConnectStatus => _connectStatus;

  void setConnectStatus(String text) {
    _connectStatus = text;
    notifyListeners();
  }

  void setDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }
}
