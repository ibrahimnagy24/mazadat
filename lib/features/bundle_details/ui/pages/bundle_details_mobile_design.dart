import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../data/params/bundle_details_route_params.dart';
import '../widgets/bundle_details_body.dart';

class BundleDetailsMobileDesignScreen extends StatelessWidget {
  const BundleDetailsMobileDesignScreen({super.key, required this.routeParams});
  final BundleDetailsRouteParams routeParams;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: true,
      appbar: CustomAppBar(title: AppStrings.bundleDetails.tr),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BundleDetailsBody(routeParams: routeParams),
          ],
        ),
      ),
    );
  }
}
