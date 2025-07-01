import 'dart:async';
import 'package:flutter/material.dart';

import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';

class CountdownTimerWidget extends StatefulWidget {
  final DateTime endTime, startDate;
  final double? fontSize;

  const CountdownTimerWidget({
    super.key,
    required this.startDate,
    required this.endTime,
    this.fontSize,
  });

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer _timer;
  Duration _remainingTime = const Duration();

  final Map<String, String> _arabicNumerals = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final now = DateTime.now();

  _calculateRemainingTime() {
    if (widget.startDate.isAfter(now)) {
      _remainingTime = widget.startDate.difference(now);
    } else if (widget.endTime.isAfter(now)) {
      _remainingTime = widget.endTime.difference(now);
    } else {
      _remainingTime = const Duration();
    }
    setState(() {});
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateRemainingTime();
    });
  }

  String _convertToArabicNumerals(int number) {
    return number
        .toString()
        .split('')
        .map((digit) => _arabicNumerals[digit] ?? digit)
        .join('');
  }

  String _formatTime(int hours, int minutes, int seconds) {
    if (mainAppBloc.isArabic) {
      return '${_convertToArabicNumerals(hours)} س : ${_convertToArabicNumerals(minutes)}د : ${_convertToArabicNumerals(seconds)} ث';
    } else {
      return '${hours.toString().padLeft(2, '0')}h : ${minutes.toString().padLeft(2, '0')}m : ${seconds.toString().padLeft(2, '0')}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remainingTime.inHours;
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);

    return Text(
      _formatTime(hours, minutes, seconds),
      style: AppTextStyles.textLgMedium.copyWith(
          color: widget.startDate.isAfter(now)
              ? AppColors.textSuccess
              : AppColors.textError,
          fontSize: widget.fontSize),
    );
  }
}
