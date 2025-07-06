import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../widgets/app_settings_buttons.dart';
import '../widgets/more_app_bar.dart';
import '../widgets/more_header.dart';
import '../widgets/more_profile_buttons.dart';
import '../widgets/more_static_buttons.dart';

class MoreMobileDesign extends StatelessWidget {
  const MoreMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MoreHeader(),
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///App Bar
                        MoreAppBar(),

                        ///More Static Buttons
                        MoreStaticButtons(),

                        ///More Profile Buttons
                        MoreProfileButtons(),

                        ///App Settings Buttons
                        AppSettingsButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
