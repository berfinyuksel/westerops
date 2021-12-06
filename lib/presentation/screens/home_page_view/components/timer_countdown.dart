import 'dart:async';

import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class TimerCountDown extends StatefulWidget {
  int hour, minute, second;
  TextStyle? textStyle;
  TimerCountDown(
      {Key? key,
      required this.hour,
      required this.minute,
      required this.second,
      this.textStyle})
      : super(key: key);

  @override
  _TimerCountDownState createState() => _TimerCountDownState();
}

class _TimerCountDownState extends State<TimerCountDown> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();

    super.dispose();
  }

  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.hour < 10 ? "0${widget.hour}" : "${widget.hour}"}:${widget.minute < 10 ? "0${widget.minute}" : "${widget.minute}"}:${widget.second < 10 ? "0${widget.second}" : "${widget.second}"}',
      style: widget.textStyle ?? AppTextStyles.appBarTitleStyle,
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (widget.hour == 0 && widget.minute == 0 && widget.second == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            if (widget.second != 0) {
              widget.second--;
            } else {
              widget.second = 59;
              if (widget.minute != 0) {
                widget.minute--;
              } else {
                widget.minute = 59;
                widget.hour--;
              }
            }
          });
        }
      },
    );
  }
}
