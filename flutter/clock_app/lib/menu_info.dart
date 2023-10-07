import 'package:clock_app/enum.dart';
import 'package:flutter/foundation.dart';

class MEnuInfo extends ChangeNotifier {
  MenuType? menuTYpe;
  String? title;
  String? imageSource;
  MEnuInfo(this.menuTYpe, {this.imageSource, this.title});

  updateMenu(MEnuInfo menuInfo) {
    this.menuTYpe = menuInfo.menuTYpe;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}
