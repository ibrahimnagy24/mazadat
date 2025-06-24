part of '../widgets/register_imports.dart';

class RegisterScreenMobilePortraitDesignScreen extends StatelessWidget {
  const RegisterScreenMobilePortraitDesignScreen({super.key});

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
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [
                        RegisterFormFieldWidget(),
                        SizedBox(height: 20),
                        PrivacyAndConditionsWidget(),
                        CreateAccountButtonWidget(),
                        SizedBox(height: 12),
                        AlreadyHaveAccountWidget(),
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
