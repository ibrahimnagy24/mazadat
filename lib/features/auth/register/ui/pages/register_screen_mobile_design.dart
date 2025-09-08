part of '../widgets/register_imports.dart';

class RegisterScreenMobilePortraitDesignScreen extends StatelessWidget {
  const RegisterScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
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
            const AuthTitleImageBannerWidget(),
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    child: BlocBuilder<RegisterCubit, RegisterState>(
                      buildWhen: (previous, current) {
                        return current is RegisterStepChanged ||
                            current is RegisterInitial;
                      },
                      builder: (context, state) {
                        final currentStep =
                            context.read<RegisterCubit>().currentStep;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            GestureDetector(
                              onTap: cubit.currentStep == 1
                                  ? () {
                                      context
                                          .read<RegisterCubit>()
                                          .updateStep(0);
                                    }
                                  : () {},
                              child: Row(
                                children: [
                                  if (cubit.currentStep == 1)
                                    const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 16,
                                      color: Color.fromRGBO(22, 22, 22, 1),
                                    ),
                                  if (cubit.currentStep == 1)
                                    const SizedBox(width: 12),
                                  Expanded(
                                    child: AuthHeaderContent(
                                      title: AppStrings.registerHeader.tr,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            const RegisterProgressIndicator(),
                            const SizedBox(height: 24),
                            if (currentStep == 0)
                              const RegisterFieldStep1()
                            else
                              const RegisterFieldStep2(),
                            const SizedBox(height: 20),
                            if (currentStep == 1)
                              const PrivacyAndConditionsWidget(),
                            const CreateAccountButtonWidget(),
                            const SizedBox(height: 20),
                            const OrTextWidget(),
                            if (currentStep == 0) const SizedBox(height: 20),
                            if (currentStep == 0)
                              const LoginAsVisitorButtonWidget(),
                            const SizedBox(height: 20),
                            const Center(
                              child: SafeArea(
                                top: false,
                                child: AlreadyHaveAccountWidget(),
                              ),
                            ),
                          ],
                        );
                      },
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
