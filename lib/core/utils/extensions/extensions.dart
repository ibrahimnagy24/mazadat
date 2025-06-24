import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../navigation/custom_navigation.dart';
import '../../translation/all_translation.dart';

extension Translate on String {
  String get tr => allTranslations.text(this);
}

extension ScreenScale on num {
  double get w =>
      MediaQuery.of(CustomNavigator.navigatorState.currentContext!).size.width *
      (toDouble() / 390);
  double get h =>
      MediaQuery.of(CustomNavigator.navigatorState.currentContext!)
          .size
          .height *
      (toDouble() / 844);
}

extension EmptyPadding on num {
  SizedBox get sbH => SizedBox(height: toDouble());
  SizedBox get sbW => SizedBox(width: toDouble());
}

extension DateHelpers on DateTime {
  String toDateFormat({String? format, String? locale}) {
    final formatter =
        intl.DateFormat(format ?? 'EE, d MMM hh:mm', locale ?? 'en');
    return formatter.format(this);
  }
}
