part of '../widgets/change_phone_number_imports.dart';

class ChangePhoneNumberScreen extends StatelessWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePhoneNumberCubit(),
      child: BlocBuilder<ChangePhoneNumberCubit, ChangePhoneNumberState>(
        builder: (context, state) {
          return Form(
            key: context.read<ChangePhoneNumberCubit>().formKey,
            child: CustomScreenTypeLayoutWidget(
              mobilePortrait: (context) =>
                  const ChangePhoneNumberScreenMobilePortraitDesignScreen(),
              mobileLandscape: (context) =>
                  const ChangePhoneNumberScreenMobilePortraitDesignScreen(),
            ),
          );
        },
      ),
    );
  }
}
