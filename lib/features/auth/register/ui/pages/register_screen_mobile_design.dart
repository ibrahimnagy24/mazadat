part of '../widgets/register_imports.dart';

class RegisterScreenMobilePortraitDesignScreen extends StatelessWidget {
  const RegisterScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: StreamBuilder<int>(
                        stream: context.read<RegisterCubit>().stepStream,
                        builder: (context, snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AuthHeaderContent(
                                  title: AppStrings.registerHeader.tr),
                              const RegisterProgressIndicator(),
                              24.sbH,
                              if (snapshot.data == 0)
                                const RegisterFieldStep1()
                              else
                                const RegisterFieldStep2(),
                              20.sbH,
                              const RegisterActions(),
                              20.sbH,
                              const Center(child: AlreadyHaveAccountWidget()),
                            ],
                          );
                        }),
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
