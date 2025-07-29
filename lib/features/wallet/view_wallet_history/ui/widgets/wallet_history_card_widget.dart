import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/radius/app_radius.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/wallet_history_entity.dart';

class WalletHistoryCardWidget extends StatelessWidget {
  const WalletHistoryCardWidget({
    super.key,
    required this.wallet,
  });
  final WalletHistoryEntity wallet;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.kWhite.withValues(alpha: .4),
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.kWhite.withValues(alpha: .4)),
        borderRadius: BorderRadius.circular(AppRadius.rXS),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  _image(),
                  height: 40,
                  width: 40,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    text: wallet.title,
                    style: AppTextStyles.textLgMedium,
                  ),
                  const SizedBox(height: 2),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.transactionNumber.tr,
                        style: AppTextStyles.bodyXsReq
                            .copyWith(color: AppColors.textSecondaryParagraph),
                      ),
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: wallet.id.toString(),
                        style: AppTextStyles.bodyXsReq,
                      ),
                    ],
                  )),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MainText(
                      text: wallet.amount.toString(),
                      style: AppTextStyles.textLgMedium,
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      AppImages.saudiRiyalSymbol2,
                      height: 12,
                      width: 12,
                    )
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Image.asset(
                      AppImages.calendar,
                      height: 12,
                      width: 12,
                    ),
                    const SizedBox(width: 4),
                    MainText(
                      text: _formatDate(wallet.date),
                      style: AppTextStyles.textSmRegular,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _image() {
    switch (wallet.type) {
      case WalletHistoryType.deposit:
        return AppImages.deposite;
      case WalletHistoryType.withdraw:
        return AppImages.withdrawIcon;
    }
  }

  String _formatDate(String dateString) {
    try {
      // Parse the ISO 8601 date string
      final date = DateTime.parse(dateString);

      // Use different format based on language
      if (mainAppBloc.isArabic) {
        // For Arabic
        // Create a formatter for the time portion
        final timeFormatter = DateFormat('h:mma');

        // Month names in Arabic
        const List<String> arabicMonths = [
          'يناير',
          'فبراير',
          'مارس',
          'أبريل',
          'مايو',
          'يونيو',
          'يوليو',
          'أغسطس',
          'سبتمبر',
          'أكتوبر',
          'نوفمبر',
          'ديسمبر'
        ];

        // Get the Arabic month name
        final arabicMonth = arabicMonths[date.month - 1];

        // Format the final string: "DD arabicMonth YYYY , h:mma"
        return '${date.day} $arabicMonth ${date.year} , ${timeFormatter.format(date).toLowerCase()}';
      } else {
        // For English
        // Create a DateFormat for English date and time
        final dateFormatter = DateFormat('d MMM yyyy, h:mma');
        return dateFormatter.format(date);
      }
    } catch (e) {
      // In case of parsing error, return a placeholder
      return mainAppBloc.isArabic ? 'تاريخ غير صالح' : 'Invalid Date';
    }
  }
}
