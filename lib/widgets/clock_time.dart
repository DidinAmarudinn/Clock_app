import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockTime extends StatefulWidget {
  @override
  _ClockTimeState createState() => _ClockTimeState();
}

class _ClockTimeState extends State<ClockTime> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 20), (t) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    return Text(
      formattedTime,
      style: TextStyle(
          fontFamily: 'avenir',
          color: Colors.white,
          fontSize: 46,
          fontWeight: FontWeight.w600),
    );
  }
}
