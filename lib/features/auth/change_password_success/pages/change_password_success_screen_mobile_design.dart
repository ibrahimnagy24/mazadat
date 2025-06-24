part of '../widgets/change_password_success_imports.dart';

class ChangePasswordSuccessMobilePortraitDesignScreen extends StatelessWidget {
  const ChangePasswordSuccessMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffoldWidget(
        child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            AuthTitleWidget(needBackButton: true),
            SizedBox(height: 32),
            // Image.asset(
            //   AppImages.changePasswordSuccess,
            //   height: 250,
            //   width: 250,
            //   fit: BoxFit.contain,
            // ),
            SizedBox(height: 16),
            AuthTitleBoldText(
              text: 'AppStrings.passwordHasBeenChanged.tr',
              fontSize: 20,
            ),
            SizedBox(height: 12),
            AuthSubtitleText(
              text: 'AppStrings.yourPasswordHasBeenChangedSuccessfully.tr',
              fontSize: 14,
            ),
            SizedBox(height: 64),
            ChangePasswordSuccessButtonWidget(),
          ],
        ),
      ),
    ));
  }
}

class ChangePasswordSuccessMobileLandscapeDesignScreen extends StatelessWidget {
  const ChangePasswordSuccessMobileLandscapeDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            const AuthTitleWidget(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              needBackButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * .7,
                  child: const Column(
                    children: [
                      // Image.asset(
                      //   AppImages.changePasswordSuccess,
                      //   height: 250,
                      //   width: 250,
                      //   fit: BoxFit.contain,
                      // ),
                      SizedBox(height: 16),
                      AuthTitleBoldText(
                        fontSize: 15,
                        text: 'AppStrings.passwordHasBeenChanged.tr',
                      ),
                      SizedBox(height: 16),
                      AuthSubtitleText(
                        fontSize: 9,
                        text:
                            'AppStrings.yourPasswordHasBeenChangedSuccessfully.tr',
                      ),
                      SizedBox(height: 16),
                      ChangePasswordSuccessButtonWidget(
                        borderRadiousValue: 50,
                        fontSize: 10,
                        height: 70,
                      ),
                      SizedBox(height: 64),
                    ],
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
