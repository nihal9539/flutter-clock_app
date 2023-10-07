// ignore_for_file: prefer_const_constructors

import 'package:clock_app/SCreens/Alaram.dart';
import 'package:clock_app/SCreens/clock_view.dart';
import 'package:clock_app/data.dart';
import 'package:clock_app/enum.dart';
import 'package:clock_app/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timeZoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetsign = '';
    if (!timeZoneString.startsWith('-')) {
      offsetsign = '+';
    }
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentmenuIfno) => builderMenuButton(currentmenuIfno))
                .toList(),
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MEnuInfo>(
              builder: (BuildContext context, MEnuInfo value, Widget? child) {
                if (value.menuTYpe != MenuType.clock) {
                  return Container(
                    padding: EdgeInsets.only(left: 10, bottom: 20, top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            'Clock',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formattedTime,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 64),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Align(
                                alignment: Alignment.center,
                                child: ClockVie(
                                  size: 250,
                                ))),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Timezone',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'UTC' + offsetsign + timeZoneString,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (value.menuTYpe != MenuType.alarm) {
                  return ScreenAlaram();
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget builderMenuButton(MEnuInfo currentmenuIfno) {
    return Consumer<MEnuInfo>(
      builder: (BuildContext context, MEnuInfo value, Widget? child) {
        return TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.transparent)))),
          onPressed: () {
            var menuInfo = Provider.of<MEnuInfo>(context, listen: false);
            menuInfo.updateMenu(currentmenuIfno);
          },
          child: Column(children: [
            Image.asset(
              currentmenuIfno.imageSource ?? '',
              width: 69,
              height: 50,
              scale: 1.5,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              currentmenuIfno.title ?? '',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(
              height: 16,
            ),
          ]),
        );
      },
    );
  }
}
