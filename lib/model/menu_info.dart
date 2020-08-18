import 'package:clock_app/enum_menu.dart';
import 'package:flutter/foundation.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String titile;
  String images;

  MenuInfo(this.menuType, {this.titile, this.images});

  updateMenuInfo(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.titile = menuInfo.titile;
    this.images = menuInfo.images;

    notifyListeners();
  }
}
