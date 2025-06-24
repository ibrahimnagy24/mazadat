part of '../widgets/reset_password_imports.dart';

class ResetPasswordScreenMobilePortraitDesignScreen extends StatelessWidget {
  const ResetPasswordScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              text: AppStrings.confirmMobileNumber.tr,
              style: AppTextStyles.headingLBold
                  .copyWith(color: AppColors.kOpacityBlack),
            ),
            const SizedBox(height: 16),
            MainText(
              text:
                  '${AppStrings.pleaseEnterYourMobileNumberToSendNumVeri.tr}.',
              style:
                  AppTextStyles.bodySReq.copyWith(color: AppColors.kGeryText4),
            ),
            const SizedBox(height: 28),
            BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
              buildWhen: (previous, current) =>
                  current is ResetPasswordLoading ||
                  current is ResetPasswordSucess ||
                  current is ResetPasswordError,
              builder: (context, state) {
                return DefaultPhoneFormField(
                  controller: context.read<ResetPasswordCubit>().phone,
                  readOnly: state is ResetPasswordLoading,
                );
              },
            ),
            64.sbH,
            const ResetPasswordButtonWidget(),
          ],
        ),
      ),
    ));
  }
}
