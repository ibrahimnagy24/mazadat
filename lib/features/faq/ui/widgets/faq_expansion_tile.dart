import 'package:flutter/material.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../data/entities/faq_entity.dart';

class FaqExpansionTile extends StatelessWidget {
  const FaqExpansionTile({
    super.key,
    required this.faq,
  });

  final FaqEntity faq;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          // leading: Container(
          //   height: 36,
          //   width: 6,
          //   decoration: BoxDecoration(
          //     color: const Color.fromRGBO(81, 94, 50, 1),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          // ),
          title: Row(
            children: [
              Container(
                height: 36,
                width: 6,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(81, 94, 50, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  faq.question,
                  style: AppTextStyles.bodyXlBold
                      .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                border: Border.all(color: Colors.transparent),
              ),
              child: Text(
                faq.answer,
                style: AppTextStyles.textLgRegular
                    .copyWith(color: const Color.fromRGBO(116, 116, 116, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
