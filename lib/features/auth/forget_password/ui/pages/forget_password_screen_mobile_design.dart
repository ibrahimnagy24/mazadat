part of '../widgets/forget_password_imports.dart';

class ForgetPasswordScreenMobilePortraitDesignScreen extends StatelessWidget {
  const ForgetPasswordScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.scaffoldBackground,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const CustomBackIcon(),
              const SizedBox(height: 16),
              AuthHeaderContent(
                title: AppStrings.confirmMobileNumber.tr,
                subtitle:
                    AppStrings.pleaseEnterYourMobileNumberToSendNumVerify.tr,
              ),
              const SizedBox(height: 24),
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
              const SizedBox(height: 40),
              const ForgetPasswordButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
