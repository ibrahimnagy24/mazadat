import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/assets/app_images.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';

class ShipmentStatusWidget extends StatelessWidget {
  const ShipmentStatusWidget({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(12),
      //   border: Border.all(
      //     color: const Color.fromRGBO(22, 22, 22, 0.1),
      //     width: 1,
      //   ),
      // ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainText(
            text: 'حالة الشحن',
            style: AppTextStyles.textLgMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              _buildStatusStep(
                'تم الطلب',
                'PAID',
                isFirst: true,
              ),
              _buildStatusStep(
                'جاهز للشحن',
                'READY_FOR_SHIP',
              ),
              _buildStatusStep(
                'تم الشحن',
                'SHIPPED',
              ),
              _buildStatusStep(
                'تم التوصيل',
                'DELIVERED',
                isLast: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusStep(
    String title,
    String stepStatus, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final isActive = _isStatusActive(stepStatus);
    const activeColor = Color.fromRGBO(46, 46, 46, 1);
    const inactiveColor = Color.fromRGBO(162, 162, 162, 1);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Continuous vertical line
              if (!isFirst || !isLast)
                Positioned(
                  top: isFirst ? 28 : 0,
                  bottom: isLast ? 28 : 0,
                  child: Container(
                    width: 2,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                ),
              // Icon in the center
              Center(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    isActive
                        ? AppImages.checkCorrectIcon
                        : AppImages.unselectedIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MainText(
            text: title,
            style: AppTextStyles.textMdRegular.copyWith(
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ),
        SvgPicture.asset(
          _getTrailingIcon(stepStatus),
          width: 20,
          height: 20,
          color: isActive ? activeColor : inactiveColor,
        ),
      ],
    );
  }

  String _getTrailingIcon(String stepStatus) {
    switch (stepStatus) {
      case 'PAID':
        return AppSvg.fileValidation;
      case 'READY_FOR_SHIP':
      case 'SHIPPED':
        return AppSvg.shippingTruck;
      case 'DELIVERED':
        return AppSvg.packageDelivered;
      default:
        return AppSvg.fileValidation;
    }
  }

  bool _isStatusActive(String stepStatus) {
    final statusOrder = ['PAID', 'READY_FOR_SHIP', 'SHIPPED', 'DELIVERED'];
    final currentIndex = statusOrder.indexOf(status);
    final stepIndex = statusOrder.indexOf(stepStatus);

    if (currentIndex == -1 || stepIndex == -1) return false;

    return stepIndex <= currentIndex;
  }
}
