import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_svg.dart' show AppSvg;
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../logic/delete_address_cubit.dart';
import '../logic/delete_address_state.dart';
import 'delete_address_fail_dialog.dart';

class DeleteAddressDialog extends StatelessWidget {
  const DeleteAddressDialog(
      {super.key, required this.id, required this.modalContext});
  final int id;
  final BuildContext modalContext;

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
          Navigator.pop(modalContext);
          CustomNavigator.pop();

          CustomNavigator.push(Routes.ADDRESSES, replace: true);
        }
      }, builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppSvg.deleteAddress,
                    width: 60,
                    height: 90,
                    color: AppColors.RED,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.areYouSureYouWantToDeleteAddress.tr,
                    style: AppTextStyles.heading,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.addressWillBePermanentlyRemoved.tr,
                    style: AppTextStyles.textLgRegular,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
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
          ),
        );
      }),
    );
  }
}
