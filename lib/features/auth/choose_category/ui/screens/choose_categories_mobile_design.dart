import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../shared/auth_title_image_banner_widget.dart';
import '../widgets/categories_grid_widget.dart';

class ChooseCategoryMobilePortraitDesignScreen extends StatelessWidget {
  const ChooseCategoryMobilePortraitDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          children: [
            AuthTitleImageBannerWidget(
              title: AppStrings.chooseYourFavouriteList.tr,
              subtitle: AppStrings.chooseYourFavouriteListSubtitle.tr,
            ),
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.kOpacityGrey3,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Expanded(
                        child: SingleChildScrollView(
                          child: ChooseCategoriesGridWidget(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      DefaultButton(
                        text: AppStrings.Continue.tr,
                      ),
                      DefaultButton(
                        text: AppStrings.skip.tr,
                        onPressed: () {},
                        backgroundColor: AppColors.transparent,
                        elevation: 0,
                        textStyle: AppTextStyles.bodyXsMed
                            .copyWith(color: AppColors.kPrimary500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
