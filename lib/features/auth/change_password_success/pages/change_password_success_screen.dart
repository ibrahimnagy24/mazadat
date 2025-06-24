part of '../widgets/change_password_success_imports.dart';

class ChangePasswordSuccessScreen extends StatelessWidget {
  const ChangePasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      breakpoints: AppConstant.breakpoints,
      mobile: (_) => OrientationLayoutBuilder(
        portrait: (context) =>
            const ChangePasswordSuccessMobilePortraitDesignScreen(),
        landscape: (context) =>
            const ChangePasswordSuccessMobileLandscapeDesignScreen(),
      ),
      tablet: (_) => OrientationLayoutBuilder(
        portrait: (context) =>
            const ChangePasswordSuccessMobilePortraitDesignScreen(),
        landscape: (context) =>
            const ChangePasswordSuccessMobileLandscapeDesignScreen(),
      ),
    );
  }
}
