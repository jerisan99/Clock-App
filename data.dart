import 'package:flutter/material.dart';
import 'package:limitless/alarm_info.dart';
import 'package:limitless/enums.dart';
import 'package:limitless/theme_data.dart';

import 'menu_info.dart';


List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title: 'Clock', imageSource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm, title: 'Alarm', imageSource: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.timer, title: 'Timer', imageSource: 'assets/timer_icon.png'),
  MenuInfo(MenuType.stopwatch, title: 'Stopwatch', imageSource: 'assets/stopwatch_icon.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), GradientColors.sky, description: 'Office',),
  AlarmInfo(DateTime.now().add(Duration(hours: 2)), GradientColors.sunset, description: 'Sport', ),
];