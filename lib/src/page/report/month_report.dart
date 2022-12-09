import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:capstone_design_flutter/src/page/report/utils.dart';
import 'package:firebase_core/firebase_core.dart';

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

  final firestore = FirebaseFirestore.instance;

  getData() async {
    var result =
        await firestore.collection('dates').doc('KSOTVl6Wy3aynOzfOQSV').get();
    print(result.data());
  }

  @override
  void initState() {
    super.initState();

    getData();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  Map<DateTime, List<Event>> events = {
    DateTime.utc(2022, 12, 13): [
      Event('아침, 저작횟수:82회, 식사시간:52분'),
      Event('점심, 저작횟수:90회, 식사시간:30분')
    ],
    DateTime.utc(2022, 12, 14): [Event('아침, 저작횟수:95회, 식사시간:35분')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
    print(_selectedEvents.value);
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(19),
            child: AppBar(
              title: Text('Monthly report'),
            )),
        body: Container(
            child: Column(
          children: [
            TableCalendar(
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
