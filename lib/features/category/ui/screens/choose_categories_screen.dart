import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/category_cubit.dart';
import 'package:flutter/services.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../auth/shared/auth_header_content.dart';
import '../../../auth/shared/auth_title_image_banner_widget.dart';
import '../../../auth/visitor/ui/visitor_button_widget.dart';
import '../widgets/categories_grid_widget.dart';

class ChooseCategoriesScreen extends StatelessWidget {
  const ChooseCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..categoriesStatesHandled(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
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
                  const AuthTitleImageBannerWidget(),
                  Expanded(
                    child: Transform.translate(
                      offset: const Offset(0, -20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.w),
                            topLeft: Radius.circular(16.w),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 8.w,
                                children: [
                                  const CustomBackIcon(),
                                  Expanded(
                                    child: AuthHeaderContent(
                                      title:
                                          AppStrings.chooseYourFavouriteList.tr,
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: SingleChildScrollView(
                                  child: ChooseCategoriesGridWidget(),
                                ),
                              ),
                              24.sbH,
                              BlocBuilder<CategoryCubit, CategoryState>(
                                  builder: (context, state) {
                                return VisitorButtonWidget(
                                  buttonText: AppStrings.confirm.tr,
                                  categories: context
                                      .read<CategoryCubit>()
                                      .chosenCategories
                                      .map((e) => e.returnedCategoryIdMap())
                                      .toList(),
                                );
                              }),
                              DefaultButton(
                                text: AppStrings.skip.tr,
                                onPressed: () => CustomNavigator.push(
                                    Routes.NAV_BAR_LAYOUT,
                                    clean: true),
                                backgroundColor: AppColors.transparent,
                                elevation: 0,
                                textStyle: AppTextStyles.bodyXsMed
                                    .copyWith(color: AppColors.kPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
