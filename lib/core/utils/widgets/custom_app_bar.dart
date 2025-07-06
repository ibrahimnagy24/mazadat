import 'package:flutter/material.dart';
import '../../assets/app_svg.dart';
import '../../navigation/custom_navigation.dart';
import '../../shared/blocs/main_app_bloc.dart';
import '../../shared/widgets/custom_images.dart';
import '../../theme/colors/styles.dart';
import '../../theme/text_styles/app_font_size_styles.dart';
import '../../theme/text_styles/text_styles.dart';
import '../extensions/extensions.dart';
import '../extensions/media_query_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionChild;
  final bool withBack;
  final bool withHPadding;
  final bool withVPadding;
  final double? height;
  final bool withSafeArea;
  final Color? backColor;
  final double? actionWidth;

  const CustomAppBar(
      {super.key,
      this.title,
      this.height,
      this.backColor,
      this.withHPadding = true,
      this.withVPadding = true,
      this.withBack = true,
      this.withSafeArea = true,
      this.actionWidth,
      this.actionChild});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: withHPadding ? 24.w : 0,
        vertical: withVPadding ? 24.h : 0,
      ),
      child: SafeArea(
        top: withSafeArea,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12.w,
          children: [
            withBack && CustomNavigator.navigatorState.currentState!.canPop()
                ? InkWell(
              onTap:()=> CustomNavigator.pop(),
                  child: RotatedBox(
                      quarterTurns: mainAppBloc.lang.valueOrNull == 'en' ? 2 : 0,
                      child: customImageIconSVG(
                          imageName: AppSvg.arrowBack,
                          width: 30.w,
                          height: 24.w,
                          color: AppColors.textPrimary),
                    ),
                )
                : SizedBox(width: actionWidth ?? 30),
            Expanded(
              child: Text(
                title ?? '',
                style: AppTextStyles.textMdBold.copyWith(
                  fontSize: AppFontSizes.fsXL,
                ),
              ),
            ),
            SizedBox(
              height: actionWidth ?? 30,
              width: actionWidth ?? 30,
              child: actionChild ?? const SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(MediaQueryHelper.width, height ?? 100.h);
}
