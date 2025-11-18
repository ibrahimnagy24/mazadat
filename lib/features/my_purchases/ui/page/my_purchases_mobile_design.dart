import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../widgets/my_purchases_body.dart';
import '../widgets/my_purchases_header.dart';

class MyPurchasesMobileDesign extends StatelessWidget {
  const MyPurchasesMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: true,
      appbar: CustomAppBar(
        title: AppStrings.myPurchases.tr,
        titleStyle: AppTextStyles.displayMdBold
            .copyWith(color: const Color.fromRGBO(34, 39, 21, 1)),
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MyPurchasesHeader(),
            12.sbH,
            const MyPurchasesBody(),
          ],
        ),
      ),
    );
  }
}
