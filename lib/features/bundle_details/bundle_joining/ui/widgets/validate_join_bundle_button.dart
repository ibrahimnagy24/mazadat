import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_core.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../choose_bundle_payment/data/params/bundle_choose_payment_route_params.dart';
import '../../../choose_bundle_payment/ui/pages/bundle_choose_payment_screen.dart';
import '../../logic/validate_joining_bundle_cubit.dart';
import '../../logic/validate_joining_bundle_state.dart';
import '../pages/bundle_payment_selection_view.dart';
import 'agree_to_commission_bundle.dart';
import 'agree_to_insurance_bundle.dart';

class ValidateJoinBundleButton extends StatelessWidget {
  const ValidateJoinBundleButton({
    super.key,
    required this.id,
    this.onSuccess,
    required this.bottomSheetContext,
  });
  final int id;
  final Function()? onSuccess;
  final BuildContext bottomSheetContext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const AgreeToCommissionBundle(),
          const AgreeToInsuranceBundle(),
          8.sbH,
          DefaultButton(
            text: AppStrings.confirm.tr,
            textStyle: AppTextStyles.bodyXlBold
                .copyWith(color: const Color.fromRGBO(255, 255, 255, 1)),
            onPressed: () {
              final cubit = context.read<ValidateJoiningBundleCubit>();
              final currentState = cubit.state;

              if (cubit.commission.valueOrNull != true) {
                showToast(AppStrings.agreeToCommissionAndInsurance.tr);
              }
              if (cubit.insurance.valueOrNull != true) {
                showToast(AppStrings.agreeToCommissionAndInsurance.tr);
              }
              if (currentState is ValidateJoiningBundleSuccess) {
                if (currentState.data.isAllowed) {
                  Navigator.pop(bottomSheetContext);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    builder: (payemntBottomSheetContext) {
                      return BundleChoosePaymentScreen(
                        params: BundleChoosePaymentRouteParams(
                          bundleId: id,
                          bottomSheetContext: payemntBottomSheetContext,
                        ),
                      );
                    },
                  );
                } else {
                  showToast(currentState.data.message ?? 'غير مسموح بالانضمام');
                }
              } else {
                showToast('يرجى انتظار التحقق من صحة البيانات');
              }
            },
          ),
        ],
      ),
    );
  }
}
