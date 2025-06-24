import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../../logic/category_cubit.dart';
import 'choose_categories_mobile_design.dart';

class ChooseCategoriesScreen extends StatelessWidget {
  const ChooseCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..categoriesStatesHandled(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          return CustomScreenTypeLayoutWidget(
            mobilePortrait: (context) =>
                const ChooseCategoryMobilePortraitDesignScreen(),
            mobileLandscape: (context) =>
                const ChooseCategoryMobilePortraitDesignScreen(),
          );
        },
      ),
    );
  }
}
