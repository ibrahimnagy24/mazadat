import 'package:flutter/material.dart';

import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import 'delete_address_dialog.dart';

class DeleteAddressButton extends StatelessWidget {
  const DeleteAddressButton({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
        text: AppStrings.deleteAddress.tr,
        backgroundColor: AppColors.background,
        borderColor: AppColors.textError,
        textColor: AppColors.textError,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            constraints: const BoxConstraints(maxHeight: 300),
            builder: (modalContext) {
              return DeleteAddressDialog(id: id, modalContext: modalContext);
            },
          );
          // CustomSimpleDialog.parentSimpleDialog(
          //   isDismissible: true,
          //   customListWidget: DeleteAddressDialog(id: id),
          // );
        });
  }
}
