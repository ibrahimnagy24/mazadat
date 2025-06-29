import 'package:flutter/material.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../data/params/verify_code_route_params.dart';

class VerifyCodeTitleWidget extends StatelessWidget {
  const VerifyCodeTitleWidget({super.key, required this.params});
  final VerifyCodeRouteParams params;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${'AppStrings.weHaveSentACodeTo.tr'} ',
            style: AppTextStyles.balooBhaijaan2W400Size14kOpacityGrey3,
          ),
          TextSpan(
            text: params.countryCode + params.phone,
            style: AppTextStyles.balooBhaijaan2W600Size14kOpacityGrey3,
          ),
        ],
      ),
    );
  }
}
