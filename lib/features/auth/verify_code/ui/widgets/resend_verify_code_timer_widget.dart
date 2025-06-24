import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_core.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/shimmer/shimmer_text_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
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

        return state is ResendVerifyCodeLoading
            ? const Center(child: ShimmerTextWidget('AppStrings.loading.tr'))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainText(
                    text: 'AppStrings.sendTheCodeAgain.tr',
                    style: cubit.isResendCodeButtonActive
                        ? AppTextStyles.bodyXsMed.copyWith(
                            fontSize: subTitleSize ?? 16,
                            color: AppColors.kPrimary500,
                          )
                        : AppTextStyles.bodyXXsReq.copyWith(
                            fontSize: titleSize ?? 16,
                            color: AppColors.kGeryText6,
                          ),
                    onTap: () {
                      if (cubit.timerDuration == 0) {
                        cubit.resendVerifyCodeStatesHandled();
                      }
                    },
                  ),
                  8.sbW,
                  if (cubit.timerDuration > 0)
                    MainText(
                      text: mainAppBloc.isArabic
                          ? '0:${cubit.timerDuration}'
                          : '${cubit.timerDuration}:0',
                      style: cubit.isResendCodeButtonActive
                          ? AppTextStyles.bodyXsMed.copyWith(
                              fontSize: subTitleSize ?? 16,
                              color: AppColors.kPrimary500)
                          : AppTextStyles.bodyXsMed.copyWith(
                              fontSize: subTitleSize ?? 16,
                              color: AppColors.kPrimary500),
                    ),
                ],
              );
      },
    );
  }
}
