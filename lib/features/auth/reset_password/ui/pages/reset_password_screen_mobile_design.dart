part of '../widgets/reset_password_imports.dart';

class RestPasswordScreenMobilePortraitDesignScreen extends StatelessWidget {
  const RestPasswordScreenMobilePortraitDesignScreen({super.key});

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
                    title: AppStrings.resetPassword.tr,
                    subtitle: AppStrings
                        .pleaseWriteSomethingThatYouWillRememberAndThatIsDifficultForOthersToGuess
                        .tr),
                DefaultPasswordFormField(
                  controller: context.read<ResetPasswordCubit>().password,
                  titleText: AppStrings.newPassword.tr,
                  hintText: '*******',
                ),
                12.sbH,
                DefaultPasswordFormField(
                  controller:
                      context.read<ResetPasswordCubit>().confirmPassword,
                  titleText: AppStrings.confirmNewPassword.tr,
                  hintText: '*******',
                  validator: (value) =>
                      PasswordConfirmationValidator.passwordValidator(
                    context.read<ResetPasswordCubit>().password.text,
                    value,
                  ),
                ),
                40.sbH,
                const ResetPasswordButtonWidget(),
              ],
            ),
          ),
        ));
  }
}

class ChangePasswordScreenMobileLandscapeDesignScreen extends StatelessWidget {
  const ChangePasswordScreenMobileLandscapeDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              const AuthTitleWidget(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                needBackButton: true,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .7,
                child: Column(
                  children: [
                    const AuthTitleBoldText(
                      fontSize: 15,
                      text: 'AppStrings.resetPassword.tr',
                    ),
                    const SizedBox(height: 16),
                    const AuthSubtitleText(
                      fontSize: 9,
                      text:
                          'AppStrings.pleaseWriteSomethingThatYouWillRememberAndThatIsDifficultForOthersToGuess.tr',
                    ),
                    const SizedBox(height: 32),
                    DefaultPasswordFormField(
                      hintFontSize: 9,
                      titleFontSize: 9,
                      titleIconSize: 45,
                      borderRadious: 50,
                      controller:
                          context.read<ResetPasswordCubit>().password,
                      titleText: 'AppStrings.newPassword.tr',
                      hintText: 'AppStrings.mustConsistOf8Letters.tr',
                    ),
                    const SizedBox(height: 32),
                    DefaultPasswordFormField(
                      hintFontSize: 9,
                      titleFontSize: 9,
                      titleIconSize: 45,
                      borderRadious: 50,
                      controller:
                          context.read<ResetPasswordCubit>().confirmPassword,
                      titleText: 'AppStrings.confirmNewPassword.tr',
                      hintText: 'AppStrings.repeatPassword.tr',
                      validator: (value) =>
                          PasswordConfirmationValidator.passwordValidator(
                        context.read<ResetPasswordCubit>().password.text,
                        value,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const ResetPasswordButtonWidget(
                      borderRadiusValue: 50,
                      fontSize: 10,
                      height: 70,
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
