import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../assets/app_svg.dart';
import '../blocs/main_app_bloc.dart';
import '../../theme/text_styles/text_styles.dart';
import '../../utils/widgets/text/main_text.dart';

class DefaultCountdownTimerWidget extends StatefulWidget {
  final DateTime targetDateTime;
  final String title;
  final MainAxisAlignment mainAxisAlignment;
  final Function(int remainingSeconds)? onTimerTick;

  const DefaultCountdownTimerWidget({
    super.key,
    required this.targetDateTime,
    required this.title,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onTimerTick,
  });

  @override
  State<DefaultCountdownTimerWidget> createState() =>
      _DefaultCountdownTimerWidgetState();
}

class _DefaultCountdownTimerWidgetState
    extends State<DefaultCountdownTimerWidget> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    final difference = widget.targetDateTime.difference(now);

    if (difference.isNegative || difference.inSeconds <= 0) {
      _remainingTime = Duration.zero;
      _isExpired = true;
    } else {
      _remainingTime = difference;
      _isExpired = false;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _calculateRemainingTime();

        if (_remainingTime.inSeconds <= 0) {
          _isExpired = true;
          _timer?.cancel();
        }

        // Call the onTimerTick callback if provided
        if (widget.onTimerTick != null) {
          widget.onTimerTick!(_remainingTime.inSeconds);
        }
      });
    });
  }

  String _formatTime() {
    if (_isExpired) {
      if (mainAppBloc.isArabic) {
        return '0ث : 0 د :  0س ';
      } else {
        return '0 s : 0 m : 0 h';
      }
    }

    final hours = _remainingTime.inHours;
    final minutes = (_remainingTime.inMinutes % 60);
    final seconds = (_remainingTime.inSeconds % 60);

    if (mainAppBloc.isArabic) {
      return '$secondsث : $minutesد : $hoursس';
    } else {
      return '${seconds}s : ${minutes}m : ${hours}h';
    }
  }

  Color _getTimerColor() {
    return _isExpired ? Colors.red : Colors.green;
  }

  int get remainingTime {
    if (_remainingTime == Duration.zero || _isExpired) {
      return 0;
    }
    return _remainingTime.inSeconds;
  }

  /// Static functional method to calculate remaining time in seconds
  // static int calculateRemainingTime(DateTime targetDateTime) {
  //   final now = DateTime.now();
  //   final difference = targetDateTime.difference(now);

  //   if (difference.isNegative || difference.inSeconds <= 0) {
  //     return 0;
  //   }
  //   return difference.inSeconds;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppSvg.clockIcon,
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 4),
            MainText(
              text: widget.title,
              style: AppTextStyles.bodyXsMed.copyWith(
                color: const Color.fromRGBO(162, 162, 162, 1),
                fontSize: 12,
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        MainText(
          text: _formatTime(),
          style: AppTextStyles.bodyXlBold.copyWith(color: _getTimerColor()),
        ),
      ],
    );
  }
}
