part of '../widgets/verify_code_imports.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({
    super.key,
    required this.verifyCodeRouteParams,
  });
  final VerifyCodeRouteParams verifyCodeRouteParams;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCodeCubit()
        ..init(verifyCodeRouteParams)
        ..setResetPasswordParams()
        ..startTimer(),
      child: BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
        builder: (context, state) {
          return Form(
            key: context.read<VerifyCodeCubit>().formKey,
            child: ScreenTypeLayout.builder(
              breakpoints: AppConstant.breakpoints,
              mobile: (_) => OrientationLayoutBuilder(
                portrait: (context) =>
                    const VerifyCodeScreenMobilePortraitDesignScreen(),
                landscape: (context) =>
                    const VerifyCodeScreenMobilePortraitDesignScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
