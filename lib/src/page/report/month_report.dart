import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:capstone_design_flutter/src/page/report/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:collection';

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class Event {
  String title;
  Event(this.title);
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  ValueNotifier<List<Event>> _selectedEvents;
  var get_fire_store_data_date;
  final firestore = FirebaseFirestore.instance;

  getData() async {
    var result = await firestore.collection('dates').get();
    get_fire_store_data_date = result.docs;
    // print(get_fire_store_data_date);
    // get_fire_store_data_date.forEach((e) async {
    //   // print(e.data)
    //   print(e.id);
    //   var detail_result =
    //       await firestore.collection('dates').doc('${e.id}').get();
    //   print(detail_result.data());
    // });
  }

  @override
  void initState() {
    super.initState();
    // print('test------');
    // print(events);
    getData();
    // print('test------');

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  Map<DateTime, List<Event>> events = {
    // DateTime.utc(2022, 12, 13): [
    //   Event('아침, 저작횟수:4회, 식사시간:8분'),
    //   Event('점심, 저작횟수:6회, 식사시간:10분')
    // ],
    // DateTime.utc(2022, 12, 1): [
    //   Event('아침, 저작횟수:1회, 식사시간:12분'),
    //   Event('점심, 저작횟수:3회, 식사시간:15분')
    // ],
  };

  void setDateTime(year, month, date, eat_slot, eat_info) {
    // firebase에 등록된 정보를 Map에 저장해주는 함수
    bool valid = true;
    if (events.containsKey(DateTime.utc(year, month, date))) {
      events[DateTime.utc(year, month, date)].forEach((e) => {
            // print('---------'),
            // print(e.title),
            // print(Event('${eat_slot}: ${eat_info}').title),
            // print(e.title == Event('${eat_slot}: ${eat_info}').title),
            if (e.title == Event('${eat_slot}: ${eat_info}').title)
              {valid = false}
          });
      if (valid == true) {
        events[DateTime.utc(year, month, date)]
            .add(Event('${eat_slot}: ${eat_info}'));
      }
    } else {
      events[DateTime.utc(year, month, date)] = [
        Event('${eat_slot}: ${eat_info}')
      ];
    }
  }
  // Map<DateTime, List<Event>> events = {
  //   DateTime.utc(2022, 12, 13): [
  //     Event('아침, 저작횟수:82회, 식사시간:52분'),
  //     Event('점심, 저작횟수:90회, 식사시간:30분')
  //   ],
  //   DateTime.utc(2022, 12, 14): [Event('아침, 저작횟수:95회, 식사시간:35분')],
  // };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value =
          _getEventsForDay(selectedDay); // _selectedEvents.value에 그날의 정보가 들어있다.

      // _selectedEvents.value.forEach((element) => {print(element.title)});
    }
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
    // events[DateTime.utc(2022, 12, 18)] = [
    //   Event('아침, 저작횟수:82회, 식사시간:52분'),
    //   Event('점심, 저작횟수:90회, 식사시간:30분')
    // ];
    // get_fire_store_data_date?.forEach((e) {
    //   var year_data = int.parse(e.id.substring(0, 4));
    //   var month_data = int.parse(e.id.substring(5, 7));
    //   var date_data = int.parse(e.id.substring(8, 10));
    //   // print(year_data);
    //   // print(month_data);
    //   // print(date_data);
    // });
    // void setDateTime(year, month, date, eat_slot, eat_count, eat_time) {
    //   // firebase에 등록된 정보를 Map에 저장해주는 함수
    //   events[DateTime.utc(year, month, date)] = [
    //     Event('${eat_slot}, 저작횟수:${eat_count}, 식사시간:${eat_time}')
    //   ];
    // }
    get_fire_store_data_date?.forEach((e) async {
      var year_data = int.parse(e.id.substring(0, 4));
      var month_data = int.parse(e.id.substring(5, 7));
      var date_data = int.parse(e.id.substring(8, 10));
      print(e.id);
      // events[DateTime.utc(year_data, month_data, date_data)] = [];
      var detail_result =
          await firestore.collection('dates').doc('${e.id}').get();
      detail_result.data().forEach((key, value) {
        // events[DateTime.utc(year_data, month_data, date_data)]
        //     .add(Event('${key}: ${value}'));
        setDateTime(year_data, month_data, date_data, key, value);
      });
    });

    print(events);
    // getData();

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(19),
            child: AppBar(
              title: Text('Monthly report'),
            )),
        body: Container(
            child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15.0),
              child: TableCalendar(
                onDaySelected: _onDaySelected,
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print('${value[index]}'),
                          title: Text('${value[index].title}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )));
  }
}
