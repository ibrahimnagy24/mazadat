part of '../widgets/login_imports.dart';

class LoginScreenMobilePortraitDesignScreen extends StatelessWidget {
  const LoginScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AuthTitleImageBannerWidget(),
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        AuthHeaderContent(
                          title: AppStrings.loginHeader.tr,
                          subtitle: AppStrings.loginSubHeader.tr,
                        ),
                        const SizedBox(height: 24),
                        DefaultPhoneFormField(
                          controller: context.read<LoginCubit>().phone,
                        ),
                        const SizedBox(height: 16),
                        DefaultPasswordFormField(
                          controller: context.read<LoginCubit>().password,
                          validator: (value) => value == null || value.isEmpty
                              ? AppStrings.thisFieldIsRequired.tr
                              : null,
                        ),
                        const SizedBox(height: 6),
                        const ForgotPasswordTextWidget(),
                        const SizedBox(height: 32),
                        const LoginButtonWidget(),
                        const SizedBox(height: 24),
                        const OrTextWidget(),
                        const SizedBox(height: 24),
                        const LoginAsVisitorButtonWidget(),
                        const SizedBox(height: 24),
                        const DontHaveAccountWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
