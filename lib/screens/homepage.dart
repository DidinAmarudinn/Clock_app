import 'package:clock_app/data/colors.dart';
import 'package:clock_app/data/data.dart';
import 'package:clock_app/enum_menu.dart';
import 'package:clock_app/model/menu_info.dart';
import 'package:clock_app/screens/alarm_page.dart';
import 'package:clock_app/screens/clock_page.dart';
import 'package:clock_app/widgets/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d2f41),
      body: Row(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  MenuData().menuitems.map((e) => buildFlatButton(e)).toList()),
          VerticalDivider(
            width: 1,
            color: Colors.white70,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType == MenuType.clock) {
                  return ClockPage();
                } else if (value.menuType == MenuType.alarm) {
                  return AlarmPage();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFlatButton(MenuInfo currentMenuinfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          color: currentMenuinfo.menuType == value.menuType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenuInfo(currentMenuinfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                currentMenuinfo.images ?? '',
                scale: 1.7,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                currentMenuinfo.titile ?? '',
                style: TextStyle(fontFamily: 'avenir', color: Colors.white),
              )
            ],
          ),
        );
      },
    );
  }
}
