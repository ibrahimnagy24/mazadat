import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/shared/widgets/price_widget_with_flag_widget.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radiuos/app_radiuos.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../../core/utils/widgets/timer/countdown_timer_widget.dart';

/// Widget that displays the content of an auction inside the draggable sheet.
/// This can be customized based on the actual data you want to display.
class AuctionContent extends StatelessWidget {
  const AuctionContent({
    super.key,
    required this.auctionId,
  });

  final String auctionId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.kOpacityGrey3,
                radius: 25,
                child: Icon(Iconsax.heart, color: AppColors.iconSecondary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MainText(text: 'لوحة فنية لزهور التوليب'),
                    MainText(text: 'رقم المزاد: $auctionId'),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.kOpacityGrey3,
                  borderRadius: BorderRadius.circular(AppRadiuos.rM),
                  border: Border.all(color: AppColors.kOpacityGrey),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: const MainText(text: 'عامة'),
              )
            ],
          ),
          const SizedBox(height: 16),
          DottedBorder(
            options: const RectDottedBorderOptions(
              strokeWidth: 1,
              color: Color.fromRGBO(138, 147, 118, 1),
              dashPattern: [3, 5],
              padding: EdgeInsets.zero,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kOpacityGrey3,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kOpacityGrey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.clock,
                                color: AppColors.iconDefault400,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              MainText(
                                text: 'ينتهي بعد',
                                color: AppColors.iconDefault400,
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          CountdownTimerWidget(
                            language: mainAppBloc.isArabic ? 'ar' : 'en',
                            endTime: DateTime.parse(
                              DateTime.now()
                                  .add(const Duration(days: 1))
                                  .toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const DottedBorder(
                    options: RectDottedBorderOptions(
                      strokeWidth: 1,
                      color: Color.fromRGBO(138, 147, 118, 1),
                      dashPattern: [3, 5],
                      padding: EdgeInsets.zero,
                    ),
                    child: SizedBox(
                      width: 1,
                      height: 56,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const MainText(
                            text: 'السعر الإفتتاحي',
                            color: AppColors.iconDefault400,
                          ),
                          const SizedBox(height: 4),
                          PriceWidgetWithFlagWidget(
                            price: '1000',
                            priceStyle: AppTextStyles.bodyMBold.copyWith(
                                color: const Color.fromRGBO(81, 94, 50, 1)),
                            colorFilter: const ColorFilter.mode(
                              Color.fromRGBO(81, 94, 50, 1),
                              BlendMode.srcIn,
                            ),
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: 'وصف المنتج',
                style: AppTextStyles.balooBhaijaan2W400Size24kPrimary1000,
              ),
              const SizedBox(height: 12),
              MainText(
                text:
                    'لوحة فنية تصور زهور التوليب في مراحل تفتح مختلفةمرسومة بأسلوب كلاسيكي داخل أجواء استوديو رسام، تعكس الجمال الطبيعي والأناقة الخالدة.',
                style: AppTextStyles.balooBhaijaan2W400Size12kOpacityGrey4,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: 'القيمة التقديرية',
                style: AppTextStyles.balooBhaijaan2W400Size24kPrimary1000,
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: AppColors.kOpacityGrey3,
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: AppColors.kOpacityGrey, width: 2),
                    ),
                    child: PriceWidgetWithFlagWidget(
                      price: '12321,123,123,213',
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      colorFilter: const ColorFilter.mode(
                        Color.fromRGBO(81, 94, 50, 1),
                        BlendMode.srcIn,
                      ),
                      priceStyle: AppTextStyles
                          .balooBhaijaan2W400Size24kPrimary1000
                          .copyWith(color: const Color.fromRGBO(81, 94, 50, 1)),
                    ),
                  ),
                  PositionedDirectional(
                    top: 0,
                    start: 20,
                    child: Transform.translate(
                      offset: const Offset(0, -10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.kOpacityGrey3,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.kOpacityGrey),
                        ),
                        child: MainText(
                          text: 'السعر الحالي',
                          style: AppTextStyles
                              .balooBhaijaan2W400Size12kOpacityGrey4
                              .copyWith(color: AppColors.iconDefault400),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Iconsax.info_circle,
                    color: AppColors.iconDefault400,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                      child: MainText(
                    text:
                        'السعر الحالي محدد تلقائيا بناءاً علي نسبة من قيمة السعر الإفتتاحي',
                    style: AppTextStyles.balooBhaijaan2W400Size12kOpacityGrey4,
                  ))
                ],
              )
            ],
          ),
          const SizedBox(height: 50),
          DefaultButton(
            onPressed: () {},
            text: 'الانضمام للحجز',
          ),
        ],
      ),
    );
  }
}
