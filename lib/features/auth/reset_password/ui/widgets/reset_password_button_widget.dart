import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/toast_service.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../logic/reset_password_cubit.dart';
import '../../logic/reset_password_state.dart';
import 'reset_password_success_dialog.dart';

class ResetPasswordButtonWidget extends StatelessWidget {
  const ResetPasswordButtonWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadiusValue,
    this.fontSize,
  });
  final double? height;
  final double? width;
  final double? borderRadiusValue;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (previous, current) =>
          current is ResetPasswordError || current is ResetPasswordSuccess,
      listener: (context, state) {
        if (state is ResetPasswordError) {
          ToastService.showCustom(
            message: state.error.message,
            context: context,
            toastStatusType: ToastStatusType.error,
            errorEntity: state.error,
          );
        }
        if (state is ResetPasswordSuccess) {
          FocusScope.of(context).unfocus();
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            enableDrag: false,
            showDragHandle: false,
            builder: (context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: const ResetPasswordSuccessDialog(),
              );
            },
          );
        }
      },
      buildWhen: (previous, current) =>
          current is ResetPasswordLoading ||
          current is ResetPasswordSuccess ||
          current is ResetPasswordError,
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();
        return DefaultButton(
          isLoading: state is ResetPasswordLoading,
          text: AppStrings.save.tr,
          onPressed: () {
            if (cubit.isNewPasswordValid()) {
              FocusScope.of(context).unfocus();
              cubit.resetPasswordStatesHandled();
            }
          },
          height: height,
          width: width,
          borderRadiusValue: borderRadiusValue,
          fontSize: fontSize,
          textStyle: AppTextStyles.bodyXlBold.copyWith(color: AppColors.kWhite),
        );
      },
    );
  }
}
