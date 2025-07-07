part of '../widgets/forget_password_imports.dart';

class ForgetPasswordScreenMobilePortraitDesignScreen extends StatelessWidget {
  const ForgetPasswordScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
        needAppbar: false,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackIcon(),
                AuthHeaderContent(
                    title: AppStrings.confirmMobileNumber.tr,
                    subtitle: AppStrings
                        .pleaseEnterYourMobileNumberToSendNumVerify.tr),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  buildWhen: (previous, current) =>
                      current is ForgetPasswordLoading ||
                      current is ForgetPasswordSuccess ||
                      current is ForgetPasswordError,
                  builder: (context, state) {
                    return DefaultPhoneFormField(
                      controller: context.read<ForgetPasswordCubit>().phone,
                      readOnly: state is ForgetPasswordLoading,
                    );
                  },
                ),
                40.sbH,
                const ForgetPasswordButtonWidget(),
              ],
            ),
          ),
        ),
    );
  }
}
