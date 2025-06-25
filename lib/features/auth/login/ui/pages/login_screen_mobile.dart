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
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthHeaderContent(
                          title: AppStrings.loginHeader.tr,
                          subtitle: AppStrings.loginSubHeader.tr,
                        ),
                        DefaultPhoneFormField(
                          controller: context.read<LoginCubit>().phone,
                        ),
                        12.sbH,
                        DefaultPasswordFormField(
                          controller: context.read<LoginCubit>().password,
                        ),
                        5.sbH,
                        const LoginRememberMeWidget(),
                        32.sbH,
                        const LoginButtonWidget(),
                        const LoginAsVisitorTextWidget(),
                        16.sbH,
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
