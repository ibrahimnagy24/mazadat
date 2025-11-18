import 'package:flutter/material.dart';
import '../../../assets/app_svg.dart';
import '../../../shared/entity/error_entity.dart';
import '../../../shared/widgets/custom_images.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../extensions/extensions.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
    this.message,
    this.onTap,
    this.error,
  });
  final String? message;
  final void Function()? onTap;
  final ErrorEntity? error;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24.h,
          children: [
            customImageIconSVG(
                imageName: AppSvg.logo,
                height: 75.h,
                width: 105.w,
                color: AppColors.kPrimary),
            Text(
              error?.message ?? message ?? '',
              style: AppTextStyles.textXLMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
