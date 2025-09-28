import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../cubit/bundle_payment_cubit.dart';
import '../../cubit/bundle_payment_state.dart';
import 'bundle_payment_list_widget.dart';

class BundlePaymentMethodsListSection extends StatelessWidget {
  const BundlePaymentMethodsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BundlePaymentCubit, BundlePaymentState>(
      buildWhen: (previous, current) {
        return current is BundlePaymentLoading ||
            current is BundlePaymentLoaded ||
            current is BundlePaymentError;
      },
      builder: (context, state) {
        final cubit = context.read<BundlePaymentCubit>();

        if (state is BundlePaymentLoading) {
          return const BundlePaymentListWidget.loading();
        }

        if (state is BundlePaymentLoaded) {
          if (state.paymentMethods.methods.isEmpty) {
            return Center(
              child: Text(
                AppStrings.noPaymentMethodsAvailable,
                style: AppTextStyles.textMdRegular,
              ),
            );
          }
          return BundlePaymentListWidget(
            paymentMethods: state.paymentMethods.methods,
            walletBalance: state.paymentMethods.walletBalance,
            onPaymentMethodSelected: (paymentMethod) {
              cubit.selectPaymentMethod(paymentMethod);
            },
            selectedPaymentMethodId: cubit.selectedPaymentMethodId,
          );
        }

        if (state is BundlePaymentError) {
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
