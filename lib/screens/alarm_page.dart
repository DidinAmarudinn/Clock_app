import 'dart:math';

import 'package:clock_app/alarm_helper.dart';
import 'package:clock_app/data/colors.dart';
import 'package:clock_app/data/data.dart';
import 'package:clock_app/main.dart';
import 'package:clock_app/model/alarm_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime _alarmTime;
  String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();

  Future<List<AlarmModel>> _alarms;
  int random() {
    Random rnd;
    int min = 0;
    int max = 5;
    rnd = new Random();
    var d = min + rnd.nextInt(max - min);
    print(d);
    return d;
  }

  @override
  void initState() {
    super.initState();
    _alarmTime = DateTime.now();
    _alarmHelper.initalizeDatabase().then((value) {
      print('datebaseloaded');
      loadAlarms();
    });
  }

  void loadAlarms() {
    if (mounted)
      setState(() {
        _alarms = _alarmHelper.getAlarms();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Text(
                "Alarm",
                style: TextStyle(
                  fontFamily: 'avenir',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: DottedBorder(
                  strokeWidth: 2,
                  dashPattern: [5, 4],
                  color: CustomColors.clockOutline,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.clockBG,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        _alarmTimeString =
                            DateFormat('HH:mm').format(DateTime.now());
                        showModalBottomSheet(
                          useRootNavigator: true,
                          clipBehavior: Clip.antiAlias,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setModalState) {
                                return Container(
                                  padding: EdgeInsets.all(32),
                                  child: Column(
                                    children: [
                                      FlatButton(
                                        onPressed: () async {
                                          var selectedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          if (selectedTime != null) {
                                            final now = DateTime.now();
                                            var selectedDateTime = DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              selectedTime.hour,
                                              selectedTime.minute,
                                            );
                                            _alarmTime = selectedDateTime;
                                            setModalState(
                                              () {
                                                _alarmTimeString =
                                                    selectedDateTime.toString();
                                              },
                                            );
                                          }
                                        },
                                        child: Text(
                                          _alarmTimeString,
                                          style: TextStyle(fontSize: 32),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text('Repeat'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                      ListTile(
                                        title: Text('Sound'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                      ListTile(
                                        title: Text('Title'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                      FloatingActionButton.extended(
                                        onPressed: () async {
                                          DateTime scheduleAlarmDateTime =
                                              _alarmTime;
                                          if (_alarmTime
                                              .isAfter(DateTime.now()))
                                            scheduleAlarmDateTime = _alarmTime;
                                          else
                                            scheduleAlarmDateTime = _alarmTime
                                                .add(Duration(days: 1));
                                          var alarmModal = AlarmModel(
                                            alarmDateTime:
                                                scheduleAlarmDateTime,
                                            gradientColorIndex: random(),
                                            title: 'alarm',
                                            isPending: 1,
                                          );
                                          _alarmHelper.insetAlarm(alarmModal);
                                          scheduleAlarm('alarmm', 'horay',
                                              scheduleAlarmDateTime);
                                          setState(() {
                                            _alarms = _alarmHelper.getAlarms();
                                          });
                                        },
                                        label: Text("save"),
                                        icon: Icon(Icons.alarm),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/add_alarm.png',
                            scale: 1.5,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Add Alarm",
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'avenir'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: FutureBuilder<List<AlarmModel>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Text('loading');
                }
                if (snapshot.hasData)
                  return ListView(
                      children: snapshot.data.map<Widget>((e) {
                    var gradientColor = GradientTemplate()
                        .gradientTemplate[e.gradientColorIndex]
                        .colors;
                    var formateed = e.alarmDateTime.toString().substring(0, 16);
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: gradientColor,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: gradientColor.first.withOpacity(0.4),
                                blurRadius: 3,
                                offset: Offset(0, 4))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.label,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  )
                                ],
                              ),
                              Switch(
                                onChanged: (bool value) {},
                                value: true,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                e.title,
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'avenir'),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 4,
                                    child: Text(
                                      formateed,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'avenir',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: IconButton(
                                      iconSize: 24,
                                      color: Colors.white,
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _alarmHelper.delete(e.id);
                                        setState(() {
                                          _alarms = _alarmHelper.getAlarms();
                                        });
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList());
                return Text("No Data");
              },
            ),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm(String title, String body, DateTime dateTime) async {
    var scheduleNotificationDateTime = dateTime.add(Duration(seconds: 10));

    var androidPlatformChanelSpesific = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for alarm notif',
      icon: 'sos',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('sos'),
    );
    var iosPlatfromChanelSpesifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platfromChannelSpesific = NotificationDetails(
        androidPlatformChanelSpesific, iosPlatfromChanelSpesifics);
    await flutterLocalNotificationsPlugin.schedule(
        0, title, body, scheduleNotificationDateTime, platfromChannelSpesific);
  }
}
