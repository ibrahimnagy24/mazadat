import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../../logic/edit_favourite_categories_cubit.dart';
import '../../logic/edit_favourite_categories_state.dart';
import 'edit_favourite_categories_update_success_dialog.dart';

class EditFavouriteCategoriesButton extends StatelessWidget {
  const EditFavouriteCategoriesButton({
    super.key,
    this.height,
    this.width,
    this.borderRadiusValue,
    this.fontSize,
    this.animationBorderRadius,
  });
  final double? height;
  final double? width;
  final double? borderRadiusValue;
  final double? fontSize;
  final double? animationBorderRadius;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditFavouriteCategoriesCubit, EditFavouriteCategoriesState>(
      listenWhen: (previous, current) =>
          current is EditFavouriteCategories || current is EditFavouriteCategoriesSuccess,
      listener: (context, state) {
        if (state is EditFavouriteCategories) {
          showErrorSnackBar(state.error.message, error: state.error);
        }
        if (state is EditFavouriteCategoriesSuccess) {
          FocusScope.of(context).unfocus();
          CustomSimpleDialog.parentSimpleDialog(
            isDismissible: false,
            customListWidget: const EditFavouriteCategoriesUpdateSuccessDialog(),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is EditFavouriteCategoriesLoading ||
          current is EditFavouriteCategoriesSuccess ||
          current is EditFavouriteCategories,
      builder: (context, state) {
        final cubit = context.read<EditFavouriteCategoriesCubit>();
        return DefaultButton(
          isLoading: state is EditFavouriteCategoriesLoading,
          text: AppStrings.save.tr,
          onPressed: () {
            if (cubit.isRegisterValidate()) {
              FocusScope.of(context).unfocus();
              cubit.editProfileStatesHandled();
            }
          },
          height: height,
          width: width,
          borderRadiusValue: borderRadiusValue,
          fontSize: fontSize,
          animationDuration: 1500.ms,
        );
      },
    );
  }
}
