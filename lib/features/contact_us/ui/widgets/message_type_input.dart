import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/app_notification.dart';
import '../../../../../core/services/toast_service.dart';
import '../../data/entities/message_type_entity.dart';
import '../../logic/contact_us_cubit.dart';
import '../../logic/contact_us_state.dart';
import 'message_type_group_view.dart';

class MessageTypeInput extends StatelessWidget {
  const MessageTypeInput({
    super.key,
    this.initialValue,
    this.onSelect,
    this.validator,
    this.fillColor,
  });
  final MessageTypeEntity? initialValue;
  final Function(MessageTypeEntity)? onSelect;
  final String? Function(String?)? validator;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactUsCubit, ContactUsState>(
      listener: (context, state) {
        if (state is MessageTypesError) {
          ToastService.showCustom(
            message: state.error.message,
            context: context,
            toastStatusType: ToastStatusType.error,
            errorEntity: state.error,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is MessageTypesLoading ||
          current is MessageTypesDone ||
          current is MessageTypesError,
      builder: (context, state) {
        final cubit = context.read<ContactUsCubit>();
        return DefaultFormField(
          titleText: AppStrings.messageType.tr,
          hintText: '${AppStrings.selectMessageType.tr}...',
          needValidation: validator != null,
          validator: validator,
          controller: TextEditingController(text: initialValue?.name ?? ''),
          readOnly: true,
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: AppColors.textSecondaryParagraph,
          ),
          fillColor: fillColor,
          onTap: () {
            if (cubit.messageTypesEntity != null &&
                cubit.messageTypesEntity!.isNotEmpty) {
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
                    child: MessageTypeGroupView(
                      data: cubit.messageTypesEntity!,
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
            if (cubit.messageTypesEntity == null &&
                state is! MessageTypesLoading) {
              cubit.getMessageTypesStatesHandled();
              AppCore.showSnackBar(
                notification: AppNotification(
                  message: AppStrings.loading.tr,
                  backgroundColor: AppColors.ALERT_COLOR,
                  borderColor: Colors.transparent,
                ),
              );
              return;
            }
            if (state is MessageTypesEmpty) {
              cubit.getMessageTypesStatesHandled();
              AppCore.showSnackBar(
                notification: AppNotification(
                  message: AppStrings.no_data.tr,
                  backgroundColor: AppColors.ALERT_COLOR,
                  borderColor: Colors.transparent,
                ),
              );
              return;
            }
            if (state is MessageTypesError) {
              cubit.getMessageTypesStatesHandled();
              return;
            }
          },
        );
      },
    );
  }
}
