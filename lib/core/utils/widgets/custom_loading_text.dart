import 'package:flutter/material.dart';
import '../../theme/colors/styles.dart';
import '../../theme/text_styles/text_styles.dart';
import '../extensions/media_query_helper.dart';

class CustomLoadingText extends StatelessWidget {
  final bool? loading;

  const CustomLoadingText({
    super.key,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading ?? true,
      child: Container(
          height: 50,
          width: MediaQueryHelper.width,
          color: AppColors.kWhite,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Loading ...',
                  style: AppTextStyles.textLgRegular,
                )
              ],
            ),
          )),
    );
  }
}
