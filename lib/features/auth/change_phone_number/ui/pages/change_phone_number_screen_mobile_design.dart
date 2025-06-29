part of '../widgets/change_phone_number_imports.dart';

class ChangePhoneNumberScreenMobilePortraitDesignScreen
    extends StatelessWidget {
  const ChangePhoneNumberScreenMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
        needAppbar: false,
        child: SafeArea(
          child: SingleChildScrollView(
            padding:  EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackIcon(),
                AuthHeaderContent(
                    title: AppStrings.changePhoneNumber.tr,
                    subtitle: AppStrings
                        .pleaseEnterYourMobileNumberToSendNumVerify.tr),
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
