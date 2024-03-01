// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:limitless/alarm_page.dart';
import 'package:limitless/clock_page.dart';
import 'package:limitless/enums.dart';
import 'package:limitless/menu_info.dart';
import 'package:limitless/stopwatch_page.dart';
import 'package:limitless/timer_page.dart';
import 'package:provider/provider.dart';
import 'clock_view.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now().toUtc().add(const Duration(hours: 2));

    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';

    return Scaffold(
        backgroundColor: Color(0xFF2D2F41),
        body: Column(
          children: [
            Expanded(
              child: Consumer<MenuInfo>(builder:
                  (BuildContext context, MenuInfo value, Widget? child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else if (value.menuType == MenuType.stopwatch)
                  return StopwatchPage();
                else if (value.menuType == MenuType.timer)
                  return TimerPage();
                else
                  return Container();
              }),
            ),
            
            Divider(
              color: Colors.white54,
              indent: 40,
              endIndent: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems
                  .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                  .toList(),
            ),
          ],
        ));
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(32))),
              backgroundColor: currentMenuInfo.menuType == value.menuType
                  ? Color(0xFF242634)
                  : Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18.0),
            ),
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Column(
              children: [
                Image.asset(
                  currentMenuInfo.imageSource,
                  scale: 1.5,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  currentMenuInfo.title ?? '',
                  style: TextStyle(
                      fontFamily: 'avenir', color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
