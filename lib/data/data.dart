import 'package:clock_app/data/colors.dart';
import 'package:clock_app/enum_menu.dart';
import 'package:clock_app/model/alarm_model.dart';
import 'package:clock_app/model/menu_info.dart';

class MenuData {
  List<MenuInfo> menuitems = [
    MenuInfo(MenuType.clock, titile: 'Clock', images: 'images/clock_icon.png'),
    MenuInfo(MenuType.alarm, titile: 'Alarm', images: 'images/alarm_icon.png'),
    MenuInfo(MenuType.timer, titile: 'Timer', images: 'images/timer_icon.png'),
    MenuInfo(MenuType.stopwatch,
        titile: 'Stopwatch', images: 'images/stopwatch_icon.png'),
  ];

  List<AlarmModel> alarms = [
    AlarmModel(
        alarmDateTime: DateTime.now().add(Duration(hours: 1)),
        title: 'Office',
        gradientColorIndex: 0),
    AlarmModel(
        alarmDateTime: DateTime.now().add(Duration(hours: 2)),
        title: 'Sport',
        gradientColorIndex: 1),
  ];
}
