import 'package:flutter/material.dart';
import '../../../../../core/assets/app_images.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';

enum AuctionResultStatus { winner, loser }

class AuctionResultsStatusWidget extends StatelessWidget {
  const AuctionResultsStatusWidget({
    super.key,
    required this.modalBuildContext,
    required this.status,
    required this.onContinue,
  });

  final BuildContext modalBuildContext;
  final AuctionResultStatus status;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final isArabic = mainAppBloc.isArabic;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          Image.asset(
            status == AuctionResultStatus.winner
                ? AppImages.checkCirculerIcon
                : AppImages.wrongCircleIcon,
            width: 90,
            height: 90,
          ),
          Text(
            _getTitle(isArabic),
            style: AppTextStyles.displaySMMedium
                .copyWith(color: const Color.fromRGBO(34, 39, 21, 1)),
            textAlign: TextAlign.center,
          ),
          Text(
            _getSubtitle(isArabic),
            style: AppTextStyles.textLgBold
                .copyWith(color: const Color.fromRGBO(162, 162, 162, 1)),
            textAlign: TextAlign.center,
          ),
          SafeArea(
            top: false,
            left: false,
            right: false,
            child: DefaultButton(
              onPressed: () {
                Navigator.pop(modalBuildContext);
                onContinue();
              },
              text: isArabic ? 'متابعة' : 'Continue',
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(bool isArabic) {
    if (status == AuctionResultStatus.winner) {
      return isArabic
          ? 'تم ترسية المزاد لصالحك'
          : 'Auction awarded in your favor';
    } else {
      return isArabic
          ? 'نأسف، لم تتم الترسية لصالحك'
          : 'Sorry, the auction was not awarded in your favor';
    }
  }

  String _getSubtitle(bool isArabic) {
    if (status == AuctionResultStatus.winner) {
      return isArabic
          ? 'سيتم تحويلك إلي صفحة إستكمال الدفع'
          : 'You will be redirected to the payment completion page';
    } else {
      return isArabic
          ? 'سيتم إعادة المبلغ إلى وسيلة الدفع المستخدمة'
          : 'The amount will be refunded to the payment method used';
    }
  }
}
