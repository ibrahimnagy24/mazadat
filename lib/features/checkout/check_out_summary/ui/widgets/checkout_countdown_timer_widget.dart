import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared/widgets/default_countdown_timer_widget.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../cubit/checkout_summary_cubit.dart';

class CheckoutCountdownTimerWidget extends StatelessWidget {
  const CheckoutCountdownTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutSummaryCubit>();

    return DottedBorder(
      options: const RectDottedBorderOptions(
        strokeWidth: 1,
        color: Color.fromRGBO(138, 147, 118, 1),
        dashPattern: [3, 5],
        padding: EdgeInsets.zero,
      ),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultCountdownTimerWidget(
              targetDateTime: cubit.checkoutSummary!.data.paymentDeadline,
              title: AppStrings.thePriceSetToCompleteThePurchase.tr,
              onTimerTick: (remainingSeconds) {
                if (remainingSeconds == 0) {
                  cubit.checkIfCheckoutTimeFinished();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
