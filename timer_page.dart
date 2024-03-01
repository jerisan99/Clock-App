// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limitless/hours.dart';
import 'package:limitless/minutes.dart';
import 'package:limitless/theme_data.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int currentHour = 0;
  int currentMinute = 0;
  var countdownDuration;
  bool start = false;

  Duration duration = Duration();
  Timer? timer;
  bool isCountdown = true;
  void initState() {
    super.initState();
  }

  void reset() {
    if (isCountdown) {
      //für Timer
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration()); //wird auf 0 gesetzt
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    countdownDuration = Duration(hours: currentHour, minutes: currentMinute);
    if (resets) {
      reset();
    }
    timer = Timer.periodic(
        Duration(seconds: 1), (_) => addTime()); //jede sec addTime aufruf
  }

  void stopTimer({bool resets = true}) {
    countdownDuration = Duration(hours: 0, minutes: 0);
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: CustomColors.clockBG,
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xffeeeeee),
                fontSize: 72,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            header,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xffeeeeee),
            ),
          )
        ],
      );

  Widget buildButtons() {
    bool isRunning = timer == null ? false : timer!.isActive;
    var isCompleted = duration.inSeconds == 0;
    return isRunning || !isCompleted || start
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                    backgroundColor: CustomColors.clockBG,
                  ),
                  onPressed: () {
                    if (isRunning) {
                      stopTimer(resets: false); //
                    } else {
                      startTimer(resets: false);
                    }
                  },
                  child: Text(
                    isRunning ? 'Stop' : 'Resume',
                    style: TextStyle(
                      color: Color(0xffeeeeee),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                    backgroundColor: CustomColors.clockBG,
                  ),
                  onPressed: () {
                    start = false;
                    currentHour = 0;
                    currentMinute = 0;
                    stopTimer();
                    setState(() {});
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xffeeeeee),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 55, vertical: 25),
                backgroundColor: CustomColors.clockBG,
              ),
              onPressed: () {
                start = true;

                startTimer();
              },
              child: Text(
                'Start',
                style: TextStyle(
                  color: Color(0xffeeeeee),
                  fontSize: 16,
                ),
              ),
            ),
          );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'Hours'),
        const SizedBox(width: 8),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget timeSetter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Hours
        Container(
          width: 70,
          height: 100,
          child: ListWheelScrollView.useDelegate(
            onSelectedItemChanged: (value) {
              setState(() {
                currentHour = value;
              });
            },
            itemExtent: 55,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 24,
              builder: (context, index) {
                return MyHours(
                  hours: index,
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        //Minutes
        Container(
          width: 70,
          height: 100,
          child: ListWheelScrollView.useDelegate(
            onSelectedItemChanged: (value) {
              setState(() {
                currentMinute = value;
              });
            },
            itemExtent: 55,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 60,
              builder: (context, index) {
                return MyMinutes(
                  mins: index,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      alignment: Alignment.center,
      color: Color(0xFF2D2F41),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Timer',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 24),
          ),
          SizedBox(
            height: 150,
          ),
          start ? buildTime() : timeSetter(),
          SizedBox(
            height: 50,
          ),
          Container(
            child: buildButtons(),
          ),
        ],
      ),
    );
  }
}
