part of '../widgets/edit_profile_imports.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          return Form(
            key: context.read<EditProfileCubit>().formKey,
            child: CustomScreenTypeLayoutWidget(
              mobilePortrait: (context) =>
                  const EditProfileScreenMobileDesign(),
              mobileLandscape: (context) =>
                  const EditProfileScreenMobileDesign(),
            ),
          );
        },
      ),
    );
  }
}
