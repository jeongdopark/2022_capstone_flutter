import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:capstone_design_flutter/src/page/home/home.dart';
import 'package:capstone_design_flutter/src/page/mypage/mypage.dart';
import 'package:capstone_design_flutter/src/page/report/report.dart';
import 'package:capstone_design_flutter/src/provider/provider_count.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

var test = '';

class ChatPage extends StatefulWidget with ChangeNotifier {
  final BluetoothDevice server;
  ChatPage({this.server});
  notifyListeners();
  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> with ChangeNotifier {
  static final clientID = 0;
  BluetoothConnection connection;
  String _messageBuffer = '';
  notifyListeners();

  List<_Message> messages = List<_Message>();

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;
  int _selectedIndex = 3;

  final List<Widget> _widgetOptions = <Widget>[
    Home(),
    report_page(),
    Mypage(),
    ChatPage()
  ];
  @override
  void initState() {
    super.initState();
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      Provider.of<AppState>(context, listen: false)
          .setBlueConnectStatus("True");
      print('Connected to the device');
      connection = _connection;
      if (mounted) {
        setState(() {
          isConnecting = false;
          isDisconnecting = false;
        });
      }

      connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
          print("연결해제 !!!!");
          // print(Provider.of<AppState>(context, listen: false)
          //     .getBlueConnectStatus);
          // Provider.of<AppState>(context, listen: false)
          //     .setBlueConnectStatus("False");
          // print(Provider.of<AppState>(context, listen: false)
          //     .getBlueConnectStatus);
          // print("여기까지 떠야한다고 !!");
        } else {
          print('Disconnected remotely!');
          print("여긴 뭐지 ?!!");
        }
        if (mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Connecting chat to ' + widget.server.name + '...')
              : isConnected
                  ? Text('블루투스 연결 양호 : ' + widget.server.name)
                  : Text('블루투스 연결이 끊겼습니다. ' + widget.server.name))),
      bottomNavigationBar: Container(
        // margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              if (mounted) {
                setState(() {
                  _selectedIndex = index;
                  HapticFeedback.lightImpact();
                });
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == _selectedIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == _selectedIndex ? displayWidth * .12 : 0,
                    width: index == _selectedIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == _selectedIndex
                          ? Colors.blueAccent.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == _selectedIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == _selectedIndex
                                ? displayWidth * .13
                                : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == _selectedIndex ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == _selectedIndex
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == _selectedIndex
                                ? displayWidth * .03
                                : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == _selectedIndex
                                ? Colors.blueAccent
                                : Colors.black26,
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
      ),
      body: _selectedIndex == 3
          ? (SafeArea(
              child: Column(
              children: <Widget>[
                Flexible(
                  child: ListView(
                      padding: const EdgeInsets.all(12.0),
                      controller: listScrollController,
                      children: list),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        child: TextField(
                          style: const TextStyle(fontSize: 15.0),
                          controller: textEditingController,
                          decoration: InputDecoration.collapsed(
                            hintText: isConnecting
                                ? 'Wait until connected...'
                                : isConnected
                                    ? 'Type your message...'
                                    : 'Chat got disconnected',
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                          enabled: isConnected,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: isConnected
                              ? () => _sendMessage(textEditingController.text)
                              : null),
                    ),
                  ],
                )
              ],
            )))
          : (_widgetOptions[_selectedIndex]),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
        test = _messageBuffer;
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
    print('data type');
    _messageBuffer = _messageBuffer.trim();
    print(_messageBuffer);

    // int test1 = int.parse(_messageBuffer.substring(12, 16));
    // Provider.of<AppState>(context, listen: false).setDisplayNumber(test1);
    print("-----------------------");
    print(Provider.of<AppState>(context, listen: false).getCountNumber);
    print("-----------------------");
    Provider.of<AppState>(context, listen: false).setCountNumber(
        Provider.of<AppState>(context, listen: false).getCountNumber + 1);
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text + "\r\n"));
        await connection.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

List<IconData> listOfIcons = [
  Icons.restaurant,
  Icons.bar_chart_rounded,
  Icons.settings_rounded,
  Icons.bluetooth_rounded,
];

List<String> listOfStrings = [
  'Home',
  'Report',
  'Setting',
  'BlT',
];
