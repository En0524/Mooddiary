import 'package:diary/diary/diary.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  DateTime today = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  bool isDoubleTap = false;

  get selectedEvent => null;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTest(),
    );
  }

  Widget _buildTest() {
    return Column(
      children: [
        const SizedBox(height: 40),
        TableCalendar(
          locale: "zh_TW",
          focusedDay: today,
          firstDay: DateTime(1990),
          lastDay: DateTime(2050),
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
          startingDayOfWeek: StartingDayOfWeek.sunday,
          daysOfWeekVisible: true,
          daysOfWeekHeight: 18,

          //Day Changed
          onDaySelected: (DateTime selectDay, DateTime focusDay) {
            if (selectedDay == selectDay && isDoubleTap) {
              // 使用者已連續點擊日期兩次
              // 在 selectedEvents 中新增一個事件
              selectedEvents[selectedDay] ??= [];
              selectedEvents[selectedDay]!.add(Event('標記', selectedDay));

              // 重置 isDoubleTap 狀態
              setState(() {
                isDoubleTap = false;
              });
            } else {
              // 使用者連續點擊日期一次，將 isDoubleTap 設為 true
              setState(() {
                isDoubleTap = true;
              });
            }
            setState(() {
              selectedDay = selectDay;
              focusedDay = focusDay;
            });
          },
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },

          eventLoader: _getEventsfromDay,

          //To style the Calendar
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            cellMargin: const EdgeInsets.all(4.0),
            cellAlignment: Alignment.center,
            selectedDecoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(248, 74, 80, 80),
                width: 3.0,
              ),
            ),
            selectedTextStyle: const TextStyle(color: Colors.black),
            todayDecoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.transparent,
                width: 3.0,
              ),
            ),
            todayTextStyle: const TextStyle(color: Colors.black),
            defaultDecoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            weekendDecoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            formatButtonShowsNext: false,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(height: 320, width: 350, child: Diary()),
      ],
    );
  }
}

class Event {
  final String title;
  final DateTime date;

  Event(this.title, this.date);
}
