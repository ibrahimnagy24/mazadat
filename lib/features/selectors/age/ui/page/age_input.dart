import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/app_notification.dart';
import '../../../../../core/services/toast_service.dart';
import '../../data/entity/age_entity.dart';
import '../../logic/age_cubit.dart';
import '../widgets/age_group_view.dart';

class AgeInput extends StatelessWidget {
  const AgeInput({
    super.key,
    this.initialValue,
    this.onSelect,
    this.validator,
  });
  final AgeEntity? initialValue;
  final Function(AgeEntity)? onSelect;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgeCubit()..agesStatesHandled(),
      child: BlocConsumer<AgeCubit, AgeState>(
        listener: (context, state) {
          if (state is AgeError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
          }
        },
        buildWhen: (previous, current) =>
            current is AgeLoading || current is AgeDone || current is AgeError,
        builder: (context, state) {
          final cubit = context.read<AgeCubit>();
          return DefaultFormField(
            titleText: AppStrings.age.tr,
            hintText: '${AppStrings.selectAge.tr}...',
            needValidation: validator != null,
            validator: validator,
            controller: TextEditingController(text: initialValue?.name ?? ''),
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.textSecondaryParagraph,
            ),
            onTap: () {
              if (cubit.agesEntity != null && cubit.agesEntity!.isNotEmpty) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  enableDrag: true,
                  isDismissible: true,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.75,
                  ),
                  builder: (modalContext) {
                    return SafeArea(
                      child: AgeGroupView(
                        data: cubit.agesEntity!,
                        initialValue: initialValue?.id,
                        onSelect: (v) {
                          onSelect?.call(v);
                          Navigator.pop(modalContext);
                        },
                        modalContext: modalContext,
                      ),
                    );
                  },
                );
                return;
              }
              if (cubit.agesEntity == null && state is! AgeLoading) {
                cubit.agesStatesHandled();
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
                return;
              }
              if (state is AgeEmpty) {
                cubit.agesStatesHandled();
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
                return;
              }
              if (state is AgeError) {
                cubit.agesStatesHandled();
                return;
              }
            },
          );
        },
      ),
    );
  }
}
