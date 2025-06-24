import 'package:flutter/material.dart';

import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';

import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import 'bundle_card_widget.dart';

class HomeBundleAuctionsWidget extends StatelessWidget {
  const HomeBundleAuctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (context, index) {
        return const BundleCardWidget();
      },
      itemCount: 10,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
    );
  }
}

class HomeBundleTitleWidget extends StatelessWidget {
  const HomeBundleTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 16, bottom: 12),
        child: MainText(
          text: AppStrings.availablePackages.tr,
          style:
              AppTextStyles.bodyMMed.copyWith(color: AppColors.kOpacityBlack),
        ),
      ),
    );
  }
}
