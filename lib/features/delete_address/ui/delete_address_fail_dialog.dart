import 'package:flutter/material.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/shared/widgets/custom_images.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/utils/extensions/media_query_helper.dart';

class DeleteAddressFailDialog extends StatelessWidget {
  const DeleteAddressFailDialog({super.key, this.error});
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQueryHelper.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                customContainerSvgIcon(
                    imageName: AppSvg.cancel,
                    width: 90.w,
                    height: 90.w,
                    padding: 12.w,
                    radius: 100.w,
                    color: AppColors.kWhite,
                    backGround: AppColors.RED),
                24.sbH,
                Text(
                  AppStrings.sorryWeCannotDeleteTheAddress.tr,
                  style: AppTextStyles.heading,
                  textAlign: TextAlign.center,
                ),
                8.sbH,
                Text(
                  error ??
                      AppStrings.theAddressIsLinkedToTheOrderDeliveryProcess.tr,
                  style: AppTextStyles.textLgRegular,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
  }
}
