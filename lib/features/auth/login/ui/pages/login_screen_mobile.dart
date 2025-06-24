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
            AuthTitleImageBannerWidget(
              title: AppStrings.welcome.tr,
              subtitle:
                  AppStrings.loginAndStartBiddingOnExclusiveOpportunities.tr,
            ),
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DefaultPhoneFormField(
                          controller: context.read<LoginCubit>().phone,
                        ),
                        12.sbH,
                        DefaultPasswordFormField(
                          controller: context.read<LoginCubit>().password,
                        ),
                        5.sbH,
                        const LoginRememberMeWidget(),
                        40.sbH,
                        const LoginButtonWidget(),
                        12.sbH,
                        const DontHaveAccountWidget(),
                        16.sbH,
                        const LoginAsVisitorTextWidget(),
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
