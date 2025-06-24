import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../logic/verify_code_cubit.dart';

class VerifyCodeTitleWidget extends StatelessWidget {
  const VerifyCodeTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final param = context.read<VerifyCodeCubit>().resetPasswordParams;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${'AppStrings.weHaveSentACodeTo.tr'} ',
            style: AppTextStyles.balooBhaijaan2W400Size14kOpacityGrey3,
          ),
          TextSpan(
            text: param.countryCode + param.phone,
            style: AppTextStyles.balooBhaijaan2W600Size14kOpacityGrey3,
          ),
        ],
      ),
    );
  }
}
