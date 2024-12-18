import 'package:attend_sys/core/calendar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalender extends StatefulWidget {
  const CustomTableCalender({super.key});

  @override
  State<CustomTableCalender> createState() => _CustomTableCalenderState();
}

class _CustomTableCalenderState extends State<CustomTableCalender> {
  DateTime focusedDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: TableCalendar(
        focusedDay: focusedDate,
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        calendarFormat: CalendarFormat.week,
        selectedDayPredicate: (day) => isSameDay(day, selectedDate),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            selectedDate = selectedDay;
            focusedDate = focusedDay;
            CustomNotifier.selectDate(selectedDay);
          });
        },
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        ),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.orange),
          weekendTextStyle: TextStyle(color: Colors.white),
          defaultTextStyle: TextStyle(color: Colors.white),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.white),
          weekendStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
