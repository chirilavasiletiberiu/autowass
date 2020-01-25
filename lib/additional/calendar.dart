import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/additional/date_utils.dart';
import 'package:intl/intl.dart';
import 'package:swipedetector/swipedetector.dart';

class GridCalendar extends StatefulWidget {
  DateTime currentDate;

  GridCalendar({@required this.currentDate});

  @override
  _GridCalendarState createState() => _GridCalendarState();
}

class _GridCalendarState extends State<GridCalendar> {
//  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return _buildPage(widget.currentDate);

//    return PageView(
//      controller: _controller,
//      scrollDirection: Axis.horizontal,
//      physics: ScrollPhysics(),
//      children:
//    );
  }

  Widget _buildPage(DateTime start) {
    return SwipeDetector(
      onSwipeRight: () {
        goNext();
      },
      onSwipeLeft: () {
        goBack();
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 40,
            child: _buildHeader(start),
          ),
          Expanded(
            child: _buildGridDateTime(start),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(DateTime start) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        7,
        (int index) {
          int weekDay = (index) % 7;

          DateTime weekDate = DateUtils.addDayToDate(start, weekDay);

          return Column(
            children: <Widget>[
              Text(
                DateUtils.getWeekDayName(weekDate),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                start.add(Duration(days: index)).day.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGridDateTime(DateTime start) {
    return GridView.count(
      crossAxisCount: 7,
      children: List.generate(
        7 * 13,
        (int index) {
          return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(1),
              color: Colors.blueGrey.shade50,
              child: new Opacity(
                  opacity: opacityValue(),
                  child: new Center(
                    child: Text(getHourByIndex(index, start),
                        textAlign: TextAlign.center),
                  )));
        },
      ),
    );
  }

  String getHourByIndex(int index, date) {
    DateTime startOfWeek =
        DateUtils.getStartOfDay(DateUtils.getFirstDayOfWeek(date));
    startOfWeek = DateUtils.addDayToDate(startOfWeek, (index % 7));

    int hoursToAdd = 6 + index ~/ 7;

    startOfWeek = DateUtils.addHourToDate(startOfWeek, hoursToAdd);

    String formattedDate = DateFormat('hh aaa').format(startOfWeek);
    return formattedDate;
  }

  double opacityValue() {
    var rng = new Random();
    int randomValue = rng.nextInt(2);

    if (randomValue % 2 == 0) {
      return 0.4;
    }

    return 1.0;
  }

  void goBack() {
    widget.currentDate = DateUtils.addDayToDate(widget.currentDate, 7);
    setState(() {});
  }

  void goNext() {
    widget.currentDate = DateUtils.addDayToDate(widget.currentDate, -7);
    setState(() {});
  }
}
