// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:limitless/data.dart';
import 'package:limitless/theme_data.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alarm',
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 24),
              ),
              SizedBox(
                height: 64,
              ),
              Expanded(
                child: ListView(
                  children: alarms.map((alarm) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: alarm.gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: alarm.gradientColors.last.withOpacity(0.4),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(4, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.label,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Office',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                    ),
                                  ),
                                ],
                              ),
                              Switch(
                                value: true,
                                onChanged: (bool value) {},
                                activeColor: Colors.white,
                              )
                            ],
                          ),
                          Text(
                            'Mon-Fri',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'avenir'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '07:00',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'avenir',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 36,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }).followedBy([
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.clockBG,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: TextButton(
                        onPressed: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/add_alarm.png',
                              scale: 1.5,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Add Alarm',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'avenir'),
                            )
                          ],
                        ),
                      ),
                    )
                  ]).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
