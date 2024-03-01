import 'package:flutter/material.dart';

class MyHours extends StatelessWidget {
  int hours;
  MyHours({required this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: Center(
        child: Text(
          hours.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}
