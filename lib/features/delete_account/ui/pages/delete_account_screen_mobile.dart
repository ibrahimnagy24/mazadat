part of '../widgets/delete_account_imports.dart';

class DeleteAccountMobilePortraitDesignScreen extends StatelessWidget {
  const DeleteAccountMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: false,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackIcon(),
              DeleteAccountContent(
                  title: AppStrings.deleteAccount.tr,
                  subtitle: AppStrings.pleaseEnterYourPasswordToConfirmDeleteAccount.tr),
              BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
                builder: (context, state) {
                  return DefaultPasswordFormField(
                    controller: context.read<DeleteAccountCubit>().password,
                  );
                },
              ),
              40.sbH,
              const ConfirmDeleteAccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}
