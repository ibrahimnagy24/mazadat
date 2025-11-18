import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../cubit/checkout_payment_cubit.dart';
import '../../cubit/checkout_payment_state.dart';
import 'checkout_payment_list_widget.dart';

class PaymentMethodsListSection extends StatelessWidget {
  const PaymentMethodsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutPaymentCubit, CheckoutPaymentState>(
      buildWhen: (previous, current) {
        return current is CheckoutPaymentLoading ||
            current is CheckoutPaymentLoaded ||
            current is CheckoutPaymentError;
      },
      builder: (context, state) {
        final cubit = context.read<CheckoutPaymentCubit>();

        if (state is CheckoutPaymentLoading) {
          return const CheckoutPaymentListWidget.loading();
        }

        if (state is CheckoutPaymentLoaded) {
          if (state.paymentMethods.methods.isEmpty) {
            return Center(
              child: Text(
                AppStrings.noPaymentMethodsAvailable,
                style: AppTextStyles.textMdRegular,
              ),
            );
          }
          return CheckoutPaymentListWidget(
            paymentMethods: state.paymentMethods.methods,
            walletBalance: state.paymentMethods.walletBalance,
            onPaymentMethodSelected: (paymentMethod) {
              cubit.selectPaymentMethod(paymentMethod);
            },
            selectedPaymentMethodId: cubit.selectedPaymentMethodId,
          );
        }

        if (state is CheckoutPaymentError) {
          return ErrorMessageWidget(
            error: state.error,
            onTap: () {
              cubit.getPaymentMethodsStatesHandled();
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
