import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/toast_service.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../view_bundle_details/data/params/bundle_details_route_params.dart';
import '../../cubit/bundle_payment_cubit.dart';
import '../../cubit/bundle_payment_state.dart';
import '../../data/params/bundle_choose_payment_route_params.dart';
import '../widgets/bundle_payment_methods_list_section.dart';
import '../widgets/bundle_payment_method_selection_section.dart';
import '../widgets/bundle_payment_status_widget.dart';

class BundleChoosePaymentScreen extends StatelessWidget {
  const BundleChoosePaymentScreen({
    super.key,
    required this.params,
  });

  final BundleChoosePaymentRouteParams params;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BundlePaymentCubit()
        ..init(params)
        ..getPaymentMethodsStatesHandled(),
      child: BlocConsumer<BundlePaymentCubit, BundlePaymentState>(
        listener: (context, state) {
          final cubit = context.read<BundlePaymentCubit>();

          if (state is SubmitJoiningSuccess) {
            ToastService.showCustom(
              message: state.entity.message,
              context: context,
              toastStatusType: ToastStatusType.success,
            );
            cubit.getBundlePaymentStatusStatesHandled(
                paymentTransactionId: int.parse(state.entity.transactionId));
          }
          if (state is SubmitJoiningError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
          }
          if (state is BundlePaymentStatusSuccess) {
            ToastService.showCustom(
              message: state.paymentStatus.message,
              context: context,
              toastStatusType: ToastStatusType.success,
            );
            // if (params.cubit != null) {
            //   // Refresh bundle details after successful payment
            //   // params.cubit!.getBundleDetails(params);
            // }

            showModalBottomSheet(
              context: context,
              isScrollControlled: false,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              isDismissible: false,
              enableDrag: false,
              showDragHandle: false,
              builder: (dialogContext) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: SafeArea(
                    top: false,
                    left: false,
                    right: false,
                    child: BundlePaymentStatusWidget(
                      dialogContext: dialogContext,
                      isPaymentSuccess: state.paymentStatus.status == 'SUCCESS'
                          ? true
                          : false,
                      onButtonPressed: () {
                        Navigator.pop(dialogContext);
                        if (state.paymentStatus.status == 'SUCCESS') {
                          Navigator.pop(params.bottomSheetContext);
                          params.cubit!.getBundleDetails(
                            BundleDetailsRouteParams(bundleId: params.bundleId),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          }
          if (state is BundlePaymentStatusError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<BundlePaymentCubit>();
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: AppStrings.selectPaymentMethod.tr,
                        style: AppTextStyles.displaySMMedium,
                      ),
                      const SizedBox(height: 16),
                      const Expanded(child: BundlePaymentMethodsListSection()),
                    ],
                  ),
                ),
              ),
              BundlePaymentMethodSelectionSection(params: params),
            ],
          );
        },
      ),
    );
  }
}
