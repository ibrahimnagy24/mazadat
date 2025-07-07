part of '../widgets/delete_account_imports.dart';


class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAccountCubit(),
      child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
        builder: (context, state) {
          return Form(
            key: context.read<DeleteAccountCubit>().formKey,
            child: CustomScreenTypeLayoutWidget(
              mobilePortrait: (context) =>
                  const DeleteAccountMobilePortraitDesignScreen(),
              mobileLandscape: (context) =>
                  const DeleteAccountMobilePortraitDesignScreen(),
            ),
          );
        },
      ),
    );
  }
}
