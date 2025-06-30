import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_core.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../logic/verify_code_cubit.dart';
import '../../logic/verify_code_state.dart';

class ResendVerifyCodeTimerWidget extends StatelessWidget {
  const ResendVerifyCodeTimerWidget({
    super.key,
    this.titleSize,
    this.subTitleSize,
  });
  final double? titleSize;
  final double? subTitleSize;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
      listener: (context, state) {
        final cubit = context.read<VerifyCodeCubit>();
        if (state is ResendVerifyCodeSucess) {
          cubit.startTimer();
        }
        if (state is ResendVerifyCodeError) {
          showErrorSnackBar(
            state.error.message,
            error: state.error,
          );
        }
      },
      listenWhen: (previous, current) =>
          current is ResendVerifyCodeLoading ||
          current is ResendVerifyCodeSucess ||
          current is ResendVerifyCodeError,
      buildWhen: (previous, current) =>
          current is ResendVerifyCodeLoading ||
          current is ResendVerifyCodeSucess ||
          current is ResendVerifyCodeError ||
          current is TimerChanged,
      builder: (context, state) {
        final cubit = context.read<VerifyCodeCubit>();

        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.didntReceiveTheCode.tr,
                style: AppTextStyles.textMdRegular,
              ),
              TextSpan(
                text: ' ${AppStrings.sendNewCode.tr}',
                style: AppTextStyles.textMdBold.copyWith(
                    color: (cubit.timerDuration == 0 &&
                            state is! ResendVerifyCodeLoading)
                        ? AppColors.kPrimary
                        : AppColors.textSecondaryParagraph),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (cubit.timerDuration == 0 && state is! ResendVerifyCodeLoading) {
                      cubit.resendVerifyCodeStatesHandled();
                    }
                  },
              ),
            ],
          ),
        );
      },
    );
  }
}
// if (cubit.timerDuration > 0)
// MainText(
//   text: mainAppBloc.isArabic
//       ? '0:${cubit.timerDuration}'
//       : '${cubit.timerDuration}:0',
//   style: cubit.isResendCodeButtonActive
//       ? AppTextStyles.bodyXsMed.copyWith(
//           fontSize: subTitleSize ?? 16,
//           color: AppColors.kPrimary500)
//       : AppTextStyles.bodyXsMed.copyWith(
//           fontSize: subTitleSize ?? 16,
//           color: AppColors.kPrimary500),
// ),
