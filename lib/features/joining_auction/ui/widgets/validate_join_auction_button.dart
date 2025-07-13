import 'package:flutter/material.dart';

import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import 'agree_to_commission.dart';
import 'agree_to_insurance.dart';

class ValidateJoinAuctionButton extends StatelessWidget {
  const ValidateJoinAuctionButton({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          const AgreeToInsurance(),
          const AgreeToCommission(),
          8.sbH,
          DefaultButton(
            text: AppStrings.confirm.tr,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
