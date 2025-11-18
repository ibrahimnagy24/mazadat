import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../app_config/app_config.dart';
import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/text_styles/text_styles.dart';

import 'default_form_field.dart';

class NumberOfQuestionsFieldWidget extends StatelessWidget {
  const NumberOfQuestionsFieldWidget({
    super.key,
    required this.controller,
    this.hintStyle,
    this.style,
    this.hintFontSize,
    this.titleFontSize,
    this.maxQuestionCount = AppConfig.maximunNumberOfQuestions,
    this.mustEvenNumbersValidation = true,
  });
  final TextEditingController controller;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final double? hintFontSize;
  final double? titleFontSize;
  final int maxQuestionCount;
  final bool mustEvenNumbersValidation;
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      hintText:
          '${mustEvenNumbersValidation ? "AppStrings.numberOfQuestionsAndMustBeEven.tr" : "AppStrings.theMaximumNumberOfQuestionsAllowdIs.tr"} ${maxQuestionCount.toString()} ...',
      keyboardType: TextInputType.number,
      controller: controller,
      hintStyle: hintStyle ??
          AppTextStyles.balooBhaijaan2W400Size14GreyText3
              .copyWith(fontSize: hintFontSize ?? 14),
      style: style ??
          AppTextStyles.balooBhaijaan2W400Size14KPrimary1000
              .copyWith(fontSize: hintFontSize ?? 14),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction((oldValue, newValue) {
          final text = newValue.text;
          if (text.isEmpty) {
            return newValue;
          }

          final number = int.tryParse(text);
          if (number != null && number >= 1 && number <= maxQuestionCount) {
            return newValue;
          }
          if (mustEvenNumbersValidation && number! % 2 == 0) {
            return newValue;
          }

          return oldValue;
        }),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'AppStrings.thisFieldIsRequired.tr';
        }
        if (int.tryParse(value) == null ||
            int.tryParse(value)! < 1 ||
            int.tryParse(value)! > (maxQuestionCount)) {
          return mainAppBloc.isArabic
              ? 'اقصي عدد هو $maxQuestionCount'
              : 'max count is $maxQuestionCount';

          // AppStrings.maximumNumberOfQuestions.tr;
        }
        return null;
      },
    );
  }
}
