import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../widgets/my_sales_body.dart';
import '../widgets/my_sales_header.dart';

class MySalesMobileDesign extends StatelessWidget {
  const MySalesMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: true,
      appbar: CustomAppBar(title: AppStrings.mySales.tr),
      child: const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const MyPurchasesHeader(),
            // 12.sbH,
            MySalesBody(),
          ],
        ),
      ),
    );
  }
}
