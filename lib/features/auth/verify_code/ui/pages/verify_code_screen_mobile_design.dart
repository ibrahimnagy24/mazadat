part of '../widgets/verify_code_imports.dart';

class VerifyCodeScreenMobilePortraitDesignScreen extends StatelessWidget {
  const VerifyCodeScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final param = context.read<VerifyCodeCubit>().resetPasswordParams;
    return CustomScaffoldWidget(
      needAppbar: false,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackIcon(),
                16.sbH,
                Row(
                  children: [
                    Expanded(
                      child: MainText(
                        text: AppStrings.verificationCode.tr,
                        style: AppTextStyles.displayMdBold,
                      ),
                    ),
                    if (param.fromScreenEnum ==
                            VerifyCodeFromScreen.fromRegister ||
                        param.fromScreenEnum == VerifyCodeFromScreen.fromLogin)
                      TextButton(
                        onPressed: () {
                          CustomNavigator.push(
                              Routes.CHANGE_PHONE_NUMBER_SCREEN,
                              extra: param.phone);
                        },
                        child: Row(
                          spacing: 4.w,
                          children: [
                            Text(
                              AppStrings.changePhoneNumber.tr,
                              style: AppTextStyles.textMdSemibold,
                              textAlign: TextAlign.start,
                            ),
                            customImageIconSVG(
                              imageName: AppSvg.edit,
                              width: 16.w,
                              height: 16.w,
                              color: AppColors.kPrimary,
                            )
                          ],
                        ),
                      )
                  ],
                ),
                12.sbH,
                BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
                    builder: (context, state) {
                  final cubit = context.read<VerifyCodeCubit>();
                  return RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              AppStrings.a4DigitVerificationCodeHasBeenSent.tr,
                          style: AppTextStyles.textLgRegular,
                        ),
                        TextSpan(
                            text:
                                ' ${mainAppBloc.isArabic ? "" : "+"}${param.countryCode}${param.phone}${mainAppBloc.isArabic ? "+" : ""} ',
                            style: AppTextStyles.textLgBold),
                        TextSpan(
                          text:
                              "${AppStrings.willBeAvailableAt.tr} (${Duration(seconds: cubit.timerDuration).inMinutes.remainder(60).toString().padLeft(2, '0')}:${Duration(seconds: cubit.timerDuration).inSeconds.remainder(60).toString().padLeft(2, '0')})",
                          style: AppTextStyles.textLgRegular,
                        ),
                      ],
                    ),
                  );
                }),
                30.sbH,
                VerifyPinCodeTextWidget(
                  controller: context.read<VerifyCodeCubit>().code,
                ),
                const Center(child: ResendVerifyCodeTimerWidget()),
                40.sbH,
                const VerifyCodeButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
