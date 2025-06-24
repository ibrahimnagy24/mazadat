import 'package:flutter/material.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../extensions/extensions.dart';
import '../buttons/custom_gradient_red_button_widget.dart';
import '../text/main_text.dart';

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({
    super.key,
    this.body,
    this.subtitle,
    this.title,
    this.cancelBtnOnPressed,
    this.cancelBtnText,
    this.okBtnOnPressed,
    this.okBtnText,
  });
  final String? title;
  final String? subtitle;
  final Widget? body;
  final String? okBtnText;
  final dynamic Function()? okBtnOnPressed;
  final String? cancelBtnText;
  final dynamic Function()? cancelBtnOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 350,
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (title != null)
                      MainText(
                        text: title,
                        style: AppTextStyles
                            .balooBhaijaan2W800Size18kPrimary1000
                            .copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    if (subtitle != null)
                      MainText(
                        text: subtitle,
                        style: AppTextStyles
                            .balooBhaijaan2W400Size14KPrimary1000
                            .copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    if (body != null) body!,
                    Row(
                      children: [
                        Expanded(
                          child: CustomGradientRedButtonWidget(
                            onPressed: okBtnOnPressed,
                            text: okBtnText,
                            color: const Color.fromRGBO(169, 169, 169, 1),
                            onPressedBoxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 0.41),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(169, 169, 169, 1),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                        8.sbW,
                        Expanded(
                          child: CustomGradientRedButtonWidget(
                            onPressed: cancelBtnOnPressed,
                            text: cancelBtnText,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
