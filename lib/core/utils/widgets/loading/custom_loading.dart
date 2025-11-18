import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../assets/app_launchers.dart';
import '../../../shared/widgets/custom_images.dart';
import '../../extensions/media_query_helper.dart';
import '../../../theme/colors/styles.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: customImageIcon(
      imageName: AppLaunchers.logo,
      height: MediaQueryHelper.width * .5,
      width: MediaQueryHelper.width * .5,
      color: AppColors.kPrimary,
    ).animate(onPlay: (controller) => controller.repeat()).shimmer(
              duration: .5.seconds,
            ));
  }
}
