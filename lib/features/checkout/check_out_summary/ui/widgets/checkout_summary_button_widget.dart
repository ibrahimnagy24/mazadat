import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/toast_service.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../cubit/checkout_summary_cubit.dart';
import '../../cubit/checkout_summary_state.dart';

class CheckoutSummaryButtonWidget extends StatelessWidget {
  const CheckoutSummaryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutSummaryCubit, CheckoutSummaryState>(
      listener: (context, state) {
        if (state is ValidateSummaryError) {
          ToastService.showCustom(
            message: state.error.message,
            context: context,
            toastStatusType: ToastStatusType.error,
            errorEntity: state.error,
          );
        }

        if (state is ValidateSummaryLoaded) {
          ToastService.showCustom(
            message: state.validateSummary.message,
            context: context,
            toastStatusType: ToastStatusType.success,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is ValidateSummaryLoading ||
          current is ValidateSummaryLoaded ||
          current is ValidateSummaryError,
      builder: (context, state) {
        return Container(
          // height: 114,
          padding: const EdgeInsetsDirectional.only(
            start: 24,
            end: 24,
            top: 8,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26.withValues(alpha: .1),
                blurRadius: .5,
                spreadRadius: .5,
                offset: const Offset(0, -1),
              )
            ],
          ),
          child: SafeArea(
            top: false,
            left: false,
            right: false,
            child: DefaultButton(
              text: AppStrings.next.tr,
              onPressed: () {
                context
                    .read<CheckoutSummaryCubit>()
                    .validateSummaryStatesHandled();
              },
              textStyle: AppTextStyles.bodyXlBold.copyWith(color: Colors.white),
              isLoading: state is ValidateSummaryLoading,
            ),
          ),
        );
      },
    );
  }
}
