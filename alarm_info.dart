import 'package:flutter/material.dart';

class AlarmInfo{
  DateTime alarmDateTime;
  String description;
  late bool isActive;
  late List<Color> gradientColors;

  AlarmInfo(this.alarmDateTime, this.gradientColors, {this.description = ''}) {
   
  }
}