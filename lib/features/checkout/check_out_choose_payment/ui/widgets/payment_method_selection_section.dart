import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/services/toast_service.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../shipment_order_details/data/params/shipment_details_route_params.dart';
import '../../cubit/checkout_payment_cubit.dart';
import '../../cubit/checkout_payment_state.dart';
import '../../data/params/checkout_choose_payment_route_params.dart';
import 'payment_status_widget.dart';

class PaymentMethodSelectionSection extends StatelessWidget {
  const PaymentMethodSelectionSection({
    super.key,
    required this.params,
  });

  final CheckoutChoosePaymentRouteParams params;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutPaymentCubit, CheckoutPaymentState>(
      listener: (context, state) {
        final cubit = context.read<CheckoutPaymentCubit>();
        if (state is ConfirmCheckoutSuccess) {
          ToastService.showCustom(
            message: state.confirmCheckout.message,
            context: context,
            toastStatusType: ToastStatusType.success,
          );
          if (int.tryParse(state.confirmCheckout.transactionId) != null) {
            cubit.getPaymentStatusStatesHandled(
              paymentTransactionId:
                  int.tryParse(state.confirmCheckout.transactionId)!,
            );
          }
        }
        if (state is ConfirmCheckoutError) {
          ToastService.showCustom(
            message: state.error.message,
            context: context,
            toastStatusType: ToastStatusType.error,
            errorEntity: state.error,
          );
        }
        if (state is PaymentStatusSuccess) {
          if (params.cubit != null) {
            params.cubit!.viewAuctionDetailsStatesHandled();
          }
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
                child: PaymentStatusWidget(
                  dialogContext: dialogContext,
                  isPaymentSuccess:
                      state.paymentStatus.status == 'SUCCESS' ? true : false,
                  onButtonPressed: () {
                    Navigator.pop(dialogContext);
                    if (state.paymentStatus.status == 'SUCCESS') {
                      CustomNavigator.push(
                        Routes.SHIPMENT_ORDER_DETAILS,
                        replace: true,
                        extra: ShipmentDetailsRouteParams(
                            shipmentId: state.paymentStatus.shipmentId),
                      );
                    }
                  },
                ),
              );
            },
          );
        }
      },
      buildWhen: (previous, current) {
        return current is SelectPaymentMethodLoading ||
            current is SelectPaymentMethodSuccess ||
            current is SelectPaymentMethodError ||
            current is ConfirmCheckoutLoading ||
            current is ConfirmCheckoutSuccess ||
            current is ConfirmCheckoutError ||
            (previous is CheckoutPaymentLoaded &&
                current is CheckoutPaymentLoaded);
      },
      builder: (context, state) {
        final cubit = context.read<CheckoutPaymentCubit>();
        final isLoading = state is SelectPaymentMethodLoading ||
            state is ConfirmCheckoutLoading;
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
                      cubit.confirmCheckoutStatesHandled(
                          paymentType: cubit.selectedPaymentMethodId!);
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
