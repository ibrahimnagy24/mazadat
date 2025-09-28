import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/services/toast_service.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../cubit/bundle_payment_cubit.dart';
import '../../cubit/bundle_payment_state.dart';
import '../../data/params/bundle_choose_payment_route_params.dart';
import 'bundle_payment_status_widget.dart';

class BundlePaymentMethodSelectionSection extends StatelessWidget {
  const BundlePaymentMethodSelectionSection({
    super.key,
    required this.params,
  });

  final BundleChoosePaymentRouteParams params;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BundlePaymentCubit, BundlePaymentState>(
      buildWhen: (previous, current) {
        return current is SubmitJoiningLoading ||
            current is SubmitJoiningSuccess ||
            current is SubmitJoiningError ||
            current is BundlePaymentStatusLoading ||
            current is BundlePaymentStatusSuccess ||
            current is BundlePaymentStatusError ||
            (previous is BundlePaymentLoaded && current is BundlePaymentLoaded);
      },
      builder: (context, state) {
        final cubit = context.read<BundlePaymentCubit>();
        final isLoading = state is SubmitJoiningLoading ||
            state is BundlePaymentStatusLoading;
        final hasSelection = cubit.selectedPaymentMethodId != null;
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
              text: AppStrings.completeTheOrder.tr,
              onPressed: hasSelection && !isLoading
                  ? () {
                      cubit.selectPaymentMethodStatesHandled(
                        paymentMethodId: cubit.selectedPaymentMethodId!,
                        bundleId: cubit.routeParams.bundleId,
                      );
                    }
                  : null,
              isLoading: isLoading,
              width: MediaQueryHelper.width,
            ),
          ),
        );
      },
    );
  }
}
