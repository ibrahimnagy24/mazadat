import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/assets/app_svg.dart' show AppSvg;
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/shared/widgets/custom_images.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/constant/app_strings.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/utils/widgets/buttons/default_button.dart';
import '../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../logic/delete_address_cubit.dart';
import '../logic/delete_address_state.dart';
import 'delete_address_fail_dialog.dart';

class DeleteAddressDialog extends StatelessWidget {
  const DeleteAddressDialog({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAddressCubit(),
      child: BlocConsumer<DeleteAddressCubit, DeleteAddressState>(
          listener: (context, state) {
        if (state is DeleteAddressError) {
          CustomNavigator.pop();
          CustomSimpleDialog.parentSimpleDialog(
            isDismissible: false,
            customListWidget: const DeleteAddressFailDialog(),
          );
        }
        if (state is DeleteAddressSuccess) {
          FocusScope.of(context).unfocus();
          CustomNavigator.pop();
          CustomNavigator.push(Routes.ADDRESSES, replace: true);
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                customImageIconSVG(
                    imageName: AppSvg.deleteAddress,
                    width: 60.w,
                    height: 90.w,
                    color: AppColors.RED),
                24.sbH,
                Text(
                  AppStrings.areYouSureYouWantToDeleteAddress.tr,
                  style: AppTextStyles.heading,
                  textAlign: TextAlign.center,
                ),
                8.sbH,
                Text(
                  AppStrings.addressWillBePermanentlyRemoved.tr,
                  style: AppTextStyles.textLgRegular,
                  textAlign: TextAlign.center,
                ),
                24.sbH,
                DefaultButton(
                  text: AppStrings.deleteAddress.tr,
                  backgroundColor: AppColors.kWhite,
                  borderColor: AppColors.textError,
                  textColor: AppColors.textError,
                  isLoading: state is DeleteAddressLoading,
                  onPressed: () => context
                      .read<DeleteAddressCubit>()
                      .deleteAddressStatesHandled(id: id),
                )
              ],
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: IconButton(
                onPressed: () => CustomNavigator.pop(),
                icon: const Icon(
                  Icons.clear,
                  size: 24,
                  color: AppColors.iconDefault,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
