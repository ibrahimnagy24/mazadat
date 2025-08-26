part of '../widgets/change_phone_number_imports.dart';

class ChangePhoneNumberScreenMobilePortraitDesignScreen
    extends StatelessWidget {
  const ChangePhoneNumberScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChangePhoneNumberCubit>();
    return CustomScaffoldWidget(
        backgroundColor: const Color.fromRGBO(238, 239, 235, 1),
        appbar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color.fromRGBO(238, 239, 235, 1),
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackIcon(),
                const SizedBox(height: 16),
                AuthHeaderContent(
                  title: AppStrings.changePhoneNumber.tr,
                  subtitle:
                      AppStrings.pleaseEnterYourMobileNumberToSendNumVerify.tr,
                ),
                const SizedBox(height: 24),
                BlocBuilder<ChangePhoneNumberCubit, ChangePhoneNumberState>(
                  buildWhen: (previous, current) =>
                      current is ChangePhoneNumberLoading ||
                      current is ChangePHoneNumberSuccess ||
                      current is ChangePhoneNumberError,
                  builder: (context, state) {
                    return DefaultPhoneFormField(
                      controller: context.read<ChangePhoneNumberCubit>().phone,
                      readOnly: state is ChangePhoneNumberLoading,
                    );
                  },
                ),
                40.sbH,
                const ChangePhoneButtonWidget(),
              ],
            ),
          ),
        ));
  }
}
