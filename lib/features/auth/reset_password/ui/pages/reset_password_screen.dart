part of '../widgets/reset_password_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.routeParams});
  final ResetPasswordRouteParams routeParams;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit()..init(routeParams),
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          return Form(
            key: context.read<ResetPasswordCubit>().formKey,
            child: ScreenTypeLayout.builder(
              breakpoints: AppConstant.breakpoints,
              mobile: (_) => OrientationLayoutBuilder(
                portrait: (context) =>
                    const RestPasswordScreenMobilePortraitDesignScreen(),
                landscape: (context) =>
                    const ChangePasswordScreenMobileLandscapeDesignScreen(),
              ),
              tablet: (_) => OrientationLayoutBuilder(
                portrait: (context) =>
                    const RestPasswordScreenMobilePortraitDesignScreen(),
                landscape: (context) =>
                    const ChangePasswordScreenMobileLandscapeDesignScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
