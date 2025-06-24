part of '../widgets/login_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Form(
            key: context.read<LoginCubit>().formKey,
            child: CustomScreenTypeLayoutWidget(
              mobilePortrait: (context) =>
                  const LoginScreenMobilePortraitDesignScreen(),
              mobileLandscape: (context) =>
                  const LoginScreenMobilePortraitDesignScreen(),
            ),
          );
        },
      ),
    );
  }
}
