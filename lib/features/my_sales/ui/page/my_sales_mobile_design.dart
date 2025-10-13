import 'package:flutter/material.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../widgets/my_sales_body.dart';
import '../widgets/my_sales_header.dart';

class MySalesMobileDesign extends StatelessWidget {
  const MySalesMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBody,
      appBar: CustomAppBar(
        title: AppStrings.mySales.tr,
        withBack: true,
        titleStyle: AppTextStyles.displayMdBold
            .copyWith(color: const Color.fromRGBO(34, 39, 21, 1)),
      ),
      body: const Column(
        children: [
          SizedBox(height: 16),
          MySalesHeader(),
          SizedBox(height: 16),
          MySalesBody(),
        ],
      ),
    );
  }
}
