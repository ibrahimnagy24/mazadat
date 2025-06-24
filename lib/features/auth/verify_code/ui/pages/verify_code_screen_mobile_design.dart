part of '../widgets/verify_code_imports.dart';

class VerifyCodeScreenMobilePortraitDesignScreen extends StatelessWidget {
  const VerifyCodeScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final param = context.read<VerifyCodeCubit>().resetPasswordParams;
    return CustomScaffoldWidget(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackIcon(),
              const SizedBox(height: 16),
              MainText(
                text: AppStrings.verificationCode.tr,
                style: AppTextStyles.headingLBold
                    .copyWith(color: AppColors.kOpacityBlack),
              ),
              const SizedBox(height: 16),
              MainText(
                text: AppStrings.a4DigitVerificationCodeHasBeenSent.tr,
                style: AppTextStyles.bodySReq,
              ),
              const SizedBox(height: 30),

              // 32.sbH,
              // AuthTitleBoldText(
              //   text: AppStrings.pleaseCheckYourEmail.tr,
              //   fontSize: 20.sp,
              // ),
              // 12.sbH,
              // const VerifyCodeTitleWidget(),
              const SizedBox(height: 24),
              VerifyPinCodeTextWidget(
                controller: context.read<VerifyCodeCubit>().code,
              ),
              const SizedBox(height: 24),
              const ResendVerifyCodeTimerWidget(),
              const SizedBox(height: 40),
              const VerifyCodeButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
