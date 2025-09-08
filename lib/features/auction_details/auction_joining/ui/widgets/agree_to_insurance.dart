import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/shared/widgets/custom_images.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../logic/validate_joining_auction_cubit.dart';
import '../../logic/validate_joining_auction_state.dart';

class AgreeToInsurance extends StatelessWidget {
  const AgreeToInsurance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidateJoiningAuctionCubit,
        ValidateJoiningAuctionState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder(
              stream:
                  context.read<ValidateJoiningAuctionCubit>().insuranceStream,
              builder: (context, snapshot) {
                return Checkbox.adaptive(
                  value: snapshot.data == true,
                  activeColor: AppColors.kPrimary,
                  checkColor: AppColors.kWhite,
                  onChanged: (value) {
                    context
                        .read<ValidateJoiningAuctionCubit>()
                        .updateInsurance(value == true);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: const BorderSide(color: AppColors.kPrimary),
                );
              }),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.youAgreeToPay.tr,
                    style: AppTextStyles.textLgRegular.copyWith(
                        color: const Color.fromRGBO(162, 162, 162, 1)),
                  ),
                  TextSpan(
                    text:
                        '${AppStrings.insuranceAmount.tr} ${(state is ValidateJoiningAuctionSuccess) ? state.data.insuranceAmount : ''}',
                    style: AppTextStyles.textLgBold
                        .copyWith(color: const Color.fromRGBO(81, 94, 50, 1)),
                  ),
                  WidgetSpan(
                    child: SvgPicture.asset(
                      AppSvg.saudiArabiaSymbol,
                      width: 16,
                      height: 16,
                      color: const Color.fromRGBO(81, 94, 50, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
