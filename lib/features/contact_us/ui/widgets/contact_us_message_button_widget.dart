import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/services/toast_service.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../logic/contact_us_cubit.dart';
import '../../logic/contact_us_state.dart';

class ContactUsMessageButtonWidget extends StatelessWidget {
  const ContactUsMessageButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactUsCubit, ContactUsState>(
      listener: (context, state) {
        if (state is ContactUsSuccess) {
          ToastService.showCustom(
            message: AppStrings.messageSentSuccessfully.tr,
            context: context,
            toastStatusType: ToastStatusType.success,
          );
          CustomNavigator.pop();
        }
        if (state is ContactUsError) {
          ToastService.showCustom(
            message: state.error.message,
            context: context,
            toastStatusType: ToastStatusType.error,
            errorEntity: state.error,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is ContactUsLoading ||
          current is ContactUsSuccess ||
          current is ContactUsError,
      builder: (context, state) {
        final isLoading = state is ContactUsLoading;
        final cubit = context.read<ContactUsCubit>();
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlack.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: DefaultButton(
              text: AppStrings.send.tr,
              onPressed: isLoading
                  ? null
                  : () {
                      cubit.submitContactUsForm();
                    },
              isLoading: isLoading,
            ),
          ),
        );
      },
    );
  }
}
