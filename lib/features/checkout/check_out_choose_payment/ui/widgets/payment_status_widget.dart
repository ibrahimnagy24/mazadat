import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';

class PaymentStatusWidget extends StatelessWidget {
  const PaymentStatusWidget({
    super.key,
    required this.dialogContext,
    required this.isPaymentSuccess,
    required this.onButtonPressed,
  });

  final BuildContext dialogContext;
  final bool isPaymentSuccess;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    isPaymentSuccess
                        ? AppImages.checkCirculerIcon
                        : AppImages.wrongCircleIcon,
                    height: 88,
                    width: 88,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          MainText(
            text: isPaymentSuccess
                ? 'تم إتمام العملية بنجاح'
                : 'نأسف، لا يوجد لديك رصيد كافٍ.',
            style: AppTextStyles.displaySMMedium,
          ),
          const SizedBox(height: 8),
          MainText(
            text: isPaymentSuccess
                ? 'سيتم إستلام الطلب خلال 15 يوماً'
                : 'الرجاء إختيار طريقة دفع آخري',
            style: AppTextStyles.textLgRegular,
          ),
          const SizedBox(height: 24),
          DefaultButton(
            backgroundColor: AppColors.buttonBackgroundPrimaryDefault,
            text: isPaymentSuccess ? 'تتبع الطلب' : 'تغيير طريقة الدفع',
            onPressed: onButtonPressed,
            textStyle:
                AppTextStyles.textXLBold.copyWith(color: AppColors.kWhite),
          )
        ],
      ),
    );
  }
}
