part of '../widgets/edit_bank_details_imports.dart';

class EditBankDetailsScreen extends StatelessWidget {
  const EditBankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditBankDetailsCubit(),
      child: BlocBuilder<EditBankDetailsCubit, EditBankDetailsState>(
        builder: (context, state) {
          return Form(
            key: context.read<EditBankDetailsCubit>().formKey,
            child: CustomScreenTypeLayoutWidget(
              mobilePortrait: (context) =>
                  const EditBankDetailsScreenMobileDesign(),
              mobileLandscape: (context) =>
                  const EditBankDetailsScreenMobileDesign(),
            ),
          );
        },
      ),
    );
  }
}
