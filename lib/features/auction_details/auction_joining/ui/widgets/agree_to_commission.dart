import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../logic/validate_joining_auction_cubit.dart';

class AgreeToCommission extends StatelessWidget {
  const AgreeToCommission({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StreamBuilder(
          stream: context.read<ValidateJoiningAuctionCubit>().commissionStream,
          builder: (context, snapshot) {
            return SizedBox(
              width: 20,
              height: 24,
              child: Checkbox.adaptive(
                value: snapshot.data == true,
                activeColor: AppColors.kPrimary,
                checkColor: AppColors.kWhite,
                onChanged: (value) {
                  context
                      .read<ValidateJoiningAuctionCubit>()
                      .updateCommission(value == true);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: const BorderSide(color: Color.fromRGBO(162, 162, 162, 1)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            );
          },
        ),
        8.sbW,
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.youAgreeToPay.tr,
                  style: AppTextStyles.textLgRegular.copyWith(
                    fontSize: 12,
                    color: const Color.fromRGBO(162, 162, 162, 1),
                  ),
                ),
                TextSpan(
                  text: AppStrings.applicationCommission.tr,
                  style: AppTextStyles.textLgBold.copyWith(
                    color: const Color.fromRGBO(81, 94, 50, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
