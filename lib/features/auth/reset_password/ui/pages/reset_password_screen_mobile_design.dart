part of '../widgets/reset_password_imports.dart';

class RestPasswordScreenMobilePortraitDesignScreen extends StatelessWidget {
  const RestPasswordScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      backgroundColor: AppColors.scaffoldBackground,
      appbar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.scaffoldBackground,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const CustomBackIcon(),
              const SizedBox(height: 16),
              AuthHeaderContent(
                title: AppStrings.resetPassword.tr,
              ),
              const SizedBox(height: 24),
              DefaultPasswordFormField(
                controller: context.read<ResetPasswordCubit>().password,
                titleText: AppStrings.newPassword.tr,
                hintText: '*******',
                needPasswordStrength: true,
              ),
              const SizedBox(height: 16),
              DefaultPasswordFormField(
                controller: context.read<ResetPasswordCubit>().confirmPassword,
                titleText: AppStrings.confirmNewPassword.tr,
                hintText: '*******',
                validator: (value) =>
                    PasswordConfirmationValidator.passwordValidator(
                  context.read<ResetPasswordCubit>().password.text,
                  value,
                ),
              ),
              const SizedBox(height: 40),
              const ResetPasswordButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
