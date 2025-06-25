import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radiuos/app_radiuos.dart';
import '../../../../core/theme/text_styles/text_styles.dart';

import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/widgets/text/main_text.dart';

class BundleCardWidget extends StatelessWidget {
  const BundleCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.rM),
        border: Border.all(color: AppColors.borderDefault),
        color: AppColors.kWhite,
      ),
      height: 96,
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _BundleImageWidget(),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 8, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _BundleTitleWidget(),
                  _BundleDescriptionWidget(),
                  _BundleInsuranceWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BundleImageWidget extends StatelessWidget {
  const _BundleImageWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.rS),
        color: AppColors.kPrimary300,
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(171, 230, 254, 1),
            Color.fromRGBO(141, 223, 255, 1),
          ],
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topCenter,
        ),
      ),
      alignment: Alignment.center,
      child: Image.asset(
        AppImages.threeDCubic,
        height: 40,
        width: 40,
      ),
    );
  }
}

class _BundleTitleWidget extends StatelessWidget {
  const _BundleTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MainText(
            text: 'مزاد سيارات نقل',
            style:
                AppTextStyles.bodyMBold.copyWith(color: AppColors.kPrimary200),
            maxLines: 1,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${AppStrings.numberOfAuctions} ',
                style: AppTextStyles.bodyXXsReq
                    .copyWith(color: AppColors.kGeryText3),
              ),
              TextSpan(
                text: '٥ ${AppStrings.auctions}',
                style: AppTextStyles.bodyXsReq
                    .copyWith(color: AppColors.kGeryText4),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _BundleDescriptionWidget extends StatelessWidget {
  const _BundleDescriptionWidget();

  @override
  Widget build(BuildContext context) {
    return MainText(
      text: '(سيارات تويوتا - سيارات نيسان - سيارات هوندا)',
      style: AppTextStyles.bodyXsReq.copyWith(color: AppColors.kGeryText6),
      maxLines: 1,
    );
  }
}

class _BundleInsuranceWidget extends StatelessWidget {
  const _BundleInsuranceWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${AppStrings.totalInsuranceAmount} ',
                style: AppTextStyles.bodyXXsReq
                    .copyWith(color: AppColors.kGeryText3),
              ),
              TextSpan(
                text: ' 50,000 ',
                style: AppTextStyles.bodyMMed
                    .copyWith(color: AppColors.kPrimary500),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        SvgPicture.asset(
          AppSvg.saudiArabiaSymbol,
          color: AppColors.kPrimary500,
        )
      ],
    );
  }
}
