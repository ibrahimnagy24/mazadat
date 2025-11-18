part of '../widgets/forget_password_imports.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          return Form(
            key: context.read<ForgetPasswordCubit>().formKey,
            child: CustomScreenTypeLayoutWidget(
              mobilePortrait: (context) =>
                  const ForgetPasswordScreenMobilePortraitDesignScreen(),
              mobileLandscape: (context) =>
                  const ForgetPasswordScreenMobilePortraitDesignScreen(),
            ),
          );
        },
      ),
    );
  }
}
