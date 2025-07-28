import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../widgets/addresses_body.dart';

class AddressesMobileDesign extends StatelessWidget {
  const AddressesMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: true,
      appbar: CustomAppBar(title: AppStrings.myAddresses.tr),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            12.sbH,
            const AddressesBody(),
          ],
        ),
      ),
    );
  }
}
