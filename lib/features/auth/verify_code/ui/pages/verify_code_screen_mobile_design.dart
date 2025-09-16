part of '../widgets/verify_code_imports.dart';

class VerifyCodeScreenMobilePortraitDesignScreen extends StatelessWidget {
  const VerifyCodeScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyCodeCubit>();
    return CustomScaffoldWidget(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.scaffoldBackground,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackIcon(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: MainText(
                        text: cubit.getTitle(),
                        style: AppTextStyles.displayMdBold,
                      ),
                    ),
                    if (cubit.resetPasswordParams.fromScreenEnum ==
                            VerifyCodeFromScreen.fromRegister ||
                        cubit.resetPasswordParams.fromScreenEnum ==
                            VerifyCodeFromScreen.fromLogin)
                      TextButton(
                        onPressed: () {
                          CustomNavigator.push(
                            Routes.CHANGE_PHONE_NUMBER_SCREEN,
                            extra: ChangePhoneNumberRouteParams(
                              oldPhone: cubit.resetPasswordParams.phone,
                            ),
                          );
                        },
                        child: Row(
                          spacing: 4,
                          children: [
                            Text(
                              AppStrings.changePhoneNumber.tr,
                              style: AppTextStyles.textMdSemibold,
                              textAlign: TextAlign.start,
                            ),
                            SvgPicture.asset(
                              AppSvg.edit,
                              width: 16,
                              height: 16,
                              color: AppColors.kPrimary,
                            )
                          ],
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 12),
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
                              ' ${mainAppBloc.isArabic ? "" : "+"}${cubit.resetPasswordParams.countryCode}${cubit.resetPasswordParams.phone}${mainAppBloc.isArabic ? "+" : ""} ',
                          style: AppTextStyles.textLgBold,
                        ),
                        TextSpan(
                          text:
                              "${AppStrings.willBeAvailableAt.tr} (${Duration(seconds: cubit.timerDuration).inMinutes.remainder(60).toString().padLeft(2, '0')}:${Duration(seconds: cubit.timerDuration).inSeconds.remainder(60).toString().padLeft(2, '0')})",
                          style: AppTextStyles.textLgRegular,
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 30),
                VerifyPinCodeTextWidget(
                  controller: context.read<VerifyCodeCubit>().code,
                ),
                const Center(child: ResendVerifyCodeTimerWidget()),
                const SizedBox(height: 40),
                const VerifyCodeButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
