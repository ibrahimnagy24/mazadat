part of '../widgets/reset_password_imports.dart';

class ResetPasswordScreenMobilePortraitDesignScreen extends StatelessWidget {
  const ResetPasswordScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
        needAppbar: false,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackIcon(),
                AuthHeaderContent(
                    title: AppStrings.confirmMobileNumber.tr,
                    subtitle: AppStrings
                        .pleaseEnterYourMobileNumberToSendNumVerify.tr),
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
