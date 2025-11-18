part of '../widgets/change_password_imports.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key, required this.params});
  final ChangePasswordRouteParams params;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit()..init(params),
      child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
        builder: (context, state) {
          return Form(
            key: context.read<ChangePasswordCubit>().formKey,
            child: ScreenTypeLayout.builder(
              breakpoints: AppConstant.breakpoints,
              mobile: (_) => OrientationLayoutBuilder(
                portrait: (context) =>
                    const ChangePasswordScreenMobilePortraitDesignScreen(),
                landscape: (context) =>
                    const ChangePasswordScreenMobileLandscapeDesignScreen(),
              ),
              tablet: (_) => OrientationLayoutBuilder(
                portrait: (context) =>
                    const ChangePasswordScreenMobilePortraitDesignScreen(),
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
