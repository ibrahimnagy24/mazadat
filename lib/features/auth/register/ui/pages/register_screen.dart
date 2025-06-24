part of '../widgets/register_imports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Form(
            key: context.read<RegisterCubit>().formKey,
            child: CustomScreenTypeLayoutWidget(
              mobilePortrait: (context) =>
                  const RegisterScreenMobilePortraitDesignScreen(),
              mobileLandscape: (context) =>
                  const RegisterScreenMobilePortraitDesignScreen(),
            ),
          );
        },
      ),
    );
  }
}
