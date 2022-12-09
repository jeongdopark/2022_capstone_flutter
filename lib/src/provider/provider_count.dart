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

  String _eatTime = ""; // 아침 점심 저녁 식사 시간 설정
  String get getEatTime => _eatTime;

  String _eatBoolean = "False"; // 체크박스 체크 여부
  String get getEatBoolean => _eatBoolean;

  String _eatMinute = ""; // 식사 시간 측정한 분단위
  String get getEatMinute => _eatMinute;

  void setEatBoolean(String text) {
    // 식사 시간 설정
    _eatBoolean = text;
    notifyListeners();
  }

  void setEatMinute(String text) {
    // 식사 시간 측정한 분단위
    // 식사 시간 설정
    _eatMinute = text;
    notifyListeners();
  }

  void setEatTime(String text) {
    // 식사 시간 설정
    _eatTime = text;
    notifyListeners();
  }

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
