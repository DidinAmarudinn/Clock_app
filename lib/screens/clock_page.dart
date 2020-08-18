import 'package:clock_app/widgets/clock_time.dart';
import 'package:clock_app/widgets/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timeZoneName = now.timeZoneName.toString().split('.').first;
    var timeZoneTime = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timeZoneTime.startsWith('-')) offsetSign = ("+");
    print(timeZoneTime);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              "Clock",
              style: TextStyle(
                fontFamily: 'avenir',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClockTime(),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      timeZoneName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w200),
                    )
                  ],
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontFamily: 'avenir',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: ClockView(MediaQuery.of(context).size.height / 4)),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Timezone",
                  style: TextStyle(
                      fontFamily: 'avenir', color: Colors.white, fontSize: 16),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.language, color: Colors.white),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "UTC" + " " + offsetSign + " " + timeZoneTime,
                      style: TextStyle(
                          fontFamily: 'avenir',
                          color: Colors.white,
                          fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
