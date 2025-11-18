import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/shared/widgets/custom_images.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../../logic/check_delete_account_cubit.dart';
import '../../logic/delete_account_state.dart';
import 'delete_account_fail_dialog.dart';

class CheckDeleteAccountDialog extends StatelessWidget {
  const CheckDeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckDeleteAccountCubit(),
      child: BlocConsumer<CheckDeleteAccountCubit, DeleteAccountState>(
          listenWhen: (previous, current) =>
              current is DeleteAccountError || current is DeleteAccountSuccess,
          listener: (context, state) {
            if (state is DeleteAccountError) {
              CustomNavigator.pop();
              CustomSimpleDialog.parentSimpleDialog(
                isDismissible: false,
                customListWidget: const DeleteAccountFailDialog(),
              );
            }
            if (state is DeleteAccountSuccess) {
              FocusScope.of(context).unfocus();
              CustomNavigator.pop();
              CustomNavigator.push(Routes.DELETE_ACCOUNT);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                customContainerSvgIcon(
                    imageName: AppSvg.delete,
                    width: 90.w,
                    height: 90.w,
                    padding: 12.w,
                    radius: 100.w,
                    color: AppColors.kWhite,
                    backGround: AppColors.RED),
                24.sbH,
                Text(
                  AppStrings.areYouSureYouWantToDeleteAccount.tr,
                  style: AppTextStyles.heading,
                  textAlign: TextAlign.center,
                ),
                8.sbH,
                Text(
                  AppStrings.youCanReactivateYourAccountAtAnyTime.tr,
                  style: AppTextStyles.textLgRegular,
                  textAlign: TextAlign.center,
                ),
                24.sbH,
                Row(
                  spacing: 12.w,
                  children: [
                    Expanded(
                      child: DefaultButton(
                        backgroundColor: AppColors.kWhite,
                        borderColor: AppColors.RED,
                        textColor: AppColors.RED,
                        text: AppStrings.deleteAccount.tr,
                        onPressed: () {
                          CustomNavigator.pop();
                          CustomNavigator.push(Routes.DELETE_ACCOUNT);
                        },
                        // onPressed: () => context
                        //     .read<CheckDeleteAccountCubit>()
                        //     .checkDeleteAccountStatesHandled(),
                      ),
                    ),
                    Expanded(
                      child: DefaultButton(
                        text: AppStrings.cancel.tr,
                        onPressed: () => CustomNavigator.pop(),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
