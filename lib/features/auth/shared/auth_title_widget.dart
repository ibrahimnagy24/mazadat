import 'package:flutter/material.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/shared/widgets/barq_text_with_flash_icon_image_widget.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/widgets/text/main_text.dart';

class AuthTitleWidget extends StatelessWidget {
  const AuthTitleWidget({
    super.key,
    this.onTap,
    this.title,
    this.needBackButton = false,
    //default is 14
    this.fontSize,
    this.mainAxisAlignment,
  });
  final Function()? onTap;
  final String? title;
  final bool needBackButton;
  final double? fontSize;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return mainAxisAlignment != null
        ? Row(
            mainAxisAlignment: mainAxisAlignment!,
            children: [
              if (needBackButton)
                CircleAvatar(
                  backgroundColor: AppColors.kPrimary50,
                  radius: 24,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.kPrimary700,
                    ),
                    onPressed: () {
                      CustomNavigator.pop();
                    },
                  ),
                ),
              const BarqTextWithFlashIconImageWidget(),
              if (title != null)
                MainText(
                  onTap: onTap,
                  text: title,
                  style: AppTextStyles.balooBhaijaan2W500Size14KPrimary1000
                      .copyWith(
                    fontSize: fontSize ?? 14,
                  ),
                ),
            ],
          )
        : Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: BarqTextWithFlashIconImageWidget(),
              ),
              if (title != null)
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: MainText(
                    onTap: onTap,
                    text: title,
                    style: AppTextStyles.balooBhaijaan2W500Size14KPrimary1000
                        .copyWith(
                      fontSize: fontSize ?? 14,
                    ),
                  ),
                ),
              if (needBackButton)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: CircleAvatar(
                    backgroundColor: AppColors.kPrimary50,
                    radius: 24,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.kPrimary700,
                      ),
                      onPressed: () {
                        CustomNavigator.pop();
                      },
                    ),
                  ),
                )
            ],
          );
  }
}
