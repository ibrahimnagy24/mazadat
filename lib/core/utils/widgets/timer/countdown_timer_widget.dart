import 'dart:async';
import 'package:flutter/material.dart';

import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';

class CountdownTimerWidget extends StatefulWidget {
  final DateTime endTime, startDate;
  final double? fontSize;
  final TextStyle? textStyle;
  final bool showSeconds;
  final bool showMinutes;

  const CountdownTimerWidget({
    super.key,
    required this.startDate,
    required this.endTime,
    this.fontSize,
    this.textStyle,
    this.showSeconds = false,
    this.showMinutes = false,
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

  _calculateRemainingTime() {
    final now = DateTime.now().toLocal();
    final endTimeLocal = widget.endTime.toLocal();
    if (endTimeLocal.isAfter(now)) {
      _remainingTime = endTimeLocal.difference(now);
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

  String _formatTime(int days, int hours, int minutes, int seconds) {
    // If days and hours are 0, force showing minutes and seconds
    bool forceMinutesAndSeconds = days == 0 && hours == 0;
    
    if (mainAppBloc.isArabic) {
      List<String> parts = [];

      if (days > 0) {
        parts.add('${_convertToArabicNumerals(days)} ي');
      }
      if (hours > 0 || days > 0) {
        parts.add('${_convertToArabicNumerals(hours)} س');
      }
      if ((widget.showMinutes && (minutes > 0 || hours > 0 || days > 0)) || forceMinutesAndSeconds) {
        parts.add('${_convertToArabicNumerals(minutes)} د');
      }
      if ((widget.showSeconds && (seconds > 0 || parts.isEmpty)) || forceMinutesAndSeconds) {
        parts.add('${_convertToArabicNumerals(seconds)} ث');
      }

      return parts.join(' : ');
    } else {
      List<String> parts = [];

      if (days > 0) {
        parts.add('${days.toString().padLeft(2, '0')}d');
      }
      if (hours > 0 || days > 0) {
        parts.add('${hours.toString().padLeft(2, '0')}h');
      }
      if ((widget.showMinutes && (minutes > 0 || hours > 0 || days > 0)) || forceMinutesAndSeconds) {
        parts.add('${minutes.toString().padLeft(2, '0')}m');
      }
      if ((widget.showSeconds && (seconds > 0 || parts.isEmpty)) || forceMinutesAndSeconds) {
        parts.add('${seconds.toString().padLeft(2, '0')}s');
      }

      return parts.join(' : ');
    }
  }

  String _formatEndDate() {
    final endTimeLocal = widget.endTime.toLocal();
    if (mainAppBloc.isArabic) {
      // Format end date in Arabic
      return '${_convertToArabicNumerals(endTimeLocal.day)}/${_convertToArabicNumerals(endTimeLocal.month)}/${_convertToArabicNumerals(endTimeLocal.year)}';
    } else {
      // Format end date in English
      return '${endTimeLocal.day.toString().padLeft(2, '0')}/${endTimeLocal.month.toString().padLeft(2, '0')}/${endTimeLocal.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final days = _remainingTime.inDays;
    final hours;
    if (days > 0) {
      hours = _remainingTime.inHours.remainder(24);
    } else {
      hours = _remainingTime.inHours;
    }
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);

    // If countdown is finished (all values are 0), show formatted end date
    if (days == 0 && hours == 0 && minutes == 0 && seconds == 0) {
      return Text(
        _formatEndDate(),
        style: widget.textStyle ??
            AppTextStyles.textLgMedium.copyWith(
                color: AppColors.textError, fontSize: widget.fontSize),
      );
    }

    return Text(
      _formatTime(days, hours, minutes, seconds),
      style: widget.textStyle ??
          AppTextStyles.textLgMedium.copyWith(
              color: _remainingTime.inSeconds > 0
                  ? AppColors.textSuccess
                  : AppColors.textError,
              fontSize: widget.fontSize),
    );
  }
}
