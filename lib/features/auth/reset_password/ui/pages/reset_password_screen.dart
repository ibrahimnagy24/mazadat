part of '../widgets/reset_password_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          return Form(
            key: context.read<ResetPasswordCubit>().formKey,
            child: CustomScreenTypeLayoutWidget(
              mobilePortrait: (context) =>
                  const ResetPasswordScreenMobilePortraitDesignScreen(),
              mobileLandscape: (context) =>
                  const ResetPasswordScreenMobilePortraitDesignScreen(),
            ),
          );
        },
      ),
    );
  }
}
