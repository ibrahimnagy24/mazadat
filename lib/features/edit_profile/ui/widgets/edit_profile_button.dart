import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../../../user/logic/user_cubit.dart';
import '../../logic/edit_profile_cubit.dart';
import '../../logic/edit_profile_state.dart';
import 'update_profile_success_dialog.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({
    super.key,
    this.height,
    this.width,
    this.borderRadiusValue,
    this.fontSize,
    this.animationBorderRadius,
  });
  final double? height;
  final double? width;
  final double? borderRadiusValue;
  final double? fontSize;
  final double? animationBorderRadius;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listenWhen: (previous, current) =>
          current is EditProfileError || current is EditProfileSuccess,
      listener: (context, state) {
        if (state is EditProfileError) {
          showErrorSnackBar(state.error.message, error: state.error);
        }
        if (state is EditProfileSuccess) {
          context.read<UserCubit>().getUserDataStatesHandled();
          FocusScope.of(context).unfocus();
          CustomSimpleDialog.parentSimpleDialog(
            isDismissible: false,
            customListWidget: const UpdateProfileSuccessDialog(),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is EditProfileLoading ||
          current is EditProfileSuccess ||
          current is EditProfileError,
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();
        return DefaultButton(
          isLoading: state is EditProfileLoading,
          text: AppStrings.save.tr,
          onPressed: () {
            if (cubit.isRegisterValidate()) {
              FocusScope.of(context).unfocus();
              cubit.editProfileStatesHandled();
            }
          },
          height: height,
          width: width,
          borderRadiusValue: borderRadiusValue,
          fontSize: fontSize,
          animationDuration: 1500.ms,
        );
      },
    );
  }
}
