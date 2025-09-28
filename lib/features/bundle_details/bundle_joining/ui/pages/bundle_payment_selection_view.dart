import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_core.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/services/toast_service.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../payment_methods/data/model/payment_model.dart';
import '../../../../payment_methods/ui/payment_list.dart';
import '../../logic/validate_joining_bundle_cubit.dart';
import '../../logic/validate_joining_bundle_state.dart';

class BundlePaymentSelectionView extends StatefulWidget {
  const BundlePaymentSelectionView({
    super.key,
    required this.bundleId,
    this.onSuccess,
  });

  final int bundleId;
  final Function()? onSuccess;

  @override
  State<BundlePaymentSelectionView> createState() =>
      _BundlePaymentSelectionViewState();
}

class _BundlePaymentSelectionViewState
    extends State<BundlePaymentSelectionView> {
  PaymentModel? selectedPayment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ValidateJoiningBundleCubit(),
      child:
          BlocConsumer<ValidateJoiningBundleCubit, ValidateJoiningBundleState>(
        listener: (context, state) {
          // Handle Submit Joining Success
          if (state is SubmitJoiningBundleSuccess) {
            ToastService.showCustom(
              message: state.message,
              context: context,
              toastStatusType: ToastStatusType.success,
            );
            CustomNavigator.pop();
            // if (state.transactionId != null) {
            //   widget.cubit.checkInsurancePayment(
            //     widget.bundleId,
            //     int.parse(state.transactionId!),
            //   );
            // }
            // widget.onSuccess?.call();
          }

          // Handle Submit Joining Error
          if (state is SubmitJoiningBundleError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
          }

          // Handle Insurance Payment Check Success - Final Step
          if (state is CheckInsurancePaymentSuccess) {
            ToastService.showCustom(
              message: state.message,
              context: context,
              toastStatusType: ToastStatusType.success,
            );
            // CustomNavigator.pop();
            // CustomNavigator.pop();

            // widget.onSuccess?.call();
          }

          // Handle Insurance Payment Check Error
          if (state is CheckInsurancePaymentError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
            // CustomNavigator.pop();
            // widget.onSuccess?.call();
          }
        },
        buildWhen: (previous, current) =>
            current is SubmitJoiningBundleLoading ||
            current is SubmitJoiningBundleError ||
            current is SubmitJoiningBundleSuccess ||
            current is CheckInsurancePaymentLoading ||
            current is CheckInsurancePaymentError ||
            current is CheckInsurancePaymentSuccess,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payment Methods List
                  Expanded(
                    child: PaymentList(
                      onSelect: (payment) {
                        setState(() {
                          selectedPayment = payment;
                        });
                      },
                      needToShowWalletOption: true,
                    ),
                  ),

                  16.sbH,

                  // Confirm Button
                  DefaultButton(
                    text: AppStrings.confirm.tr,
                    textStyle: AppTextStyles.bodyXlBold.copyWith(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    isLoading: state is SubmitJoiningBundleLoading ||
                        state is CheckInsurancePaymentLoading,
                    onPressed: selectedPayment != null &&
                            state is! SubmitJoiningBundleLoading &&
                            state is! CheckInsurancePaymentLoading
                        ? () {
                            // context
                            //     .read<ValidateJoiningBundleCubit>()
                            //     .submitJoining(
                            //       bundleId: widget.bundleId,
                            //       paymentTypeId: selectedPayment!.id!,
                            //     );
                          }
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
