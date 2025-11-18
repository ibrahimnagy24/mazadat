import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../assets/app_lottie.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/validator.dart';
import '../../validations/validation.dart';
import '../text/main_text.dart';

// ignore: must_be_immutable
class VerifiPasswordWidget extends StatefulWidget {
  VerifiPasswordWidget({super.key, required this.password});

  String password;

  @override
  State<VerifiPasswordWidget> createState() => _VerifiPasswordWidgetState();
}

class _VerifiPasswordWidgetState extends State<VerifiPasswordWidget> {
  @override
  void initState() {
    super.initState();
    widget.password = '';
  }

  String getPasswordStrengthMessage() {
    bool hasDigits =
        checkPasswordStrengthAction(widget.password)['hasDigits'] ?? false;
    bool has8Char =
        checkPasswordStrengthAction(widget.password)['hasMore8Char'] ?? false;
    bool hasSpecialChar =
        checkPasswordStrengthAction(widget.password)['hasSpecialChar'] ?? false;
    bool hasUpperCase =
        checkPasswordStrengthAction(widget.password)['hasUpper'] ?? false;

    int strength = 0;
    if (hasDigits) strength++;
    if (has8Char) strength++;
    if (hasSpecialChar) strength++;
    if (hasUpperCase) strength++;

    if (strength == 0) return 'Very Weak';
    if (strength == 1) return 'Weak';
    if (strength == 2) return 'Medium';
    if (strength == 3) return 'Strong';
    return AppStrings.veryStrong.tr;
  }

  double getPasswordStrengthProgress() {
    bool hasDigits =
        checkPasswordStrengthAction(widget.password)['hasDigits'] ?? false;
    bool has8Char =
        checkPasswordStrengthAction(widget.password)['hasMore8Char'] ?? false;
    bool hasSpecialChar =
        checkPasswordStrengthAction(widget.password)['hasSpecialChar'] ?? false;
    bool hasUpperCase =
        checkPasswordStrengthAction(widget.password)['hasUpper'] ?? false;

    int strength = 0;
    if (hasDigits) strength++;
    if (has8Char) strength++;
    if (hasSpecialChar) strength++;
    if (hasUpperCase) strength++;

    return strength / 4.0;
  }

  Color getProgressColor() {
    double progress = getPasswordStrengthProgress();
    if (progress <= 0.25) return AppColors.textError;
    if (progress <= 0.5) return Colors.orange;
    if (progress <= 0.75) return Colors.yellow;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    bool isEmptyPassword = checkPasswordStrengthAction(widget.password).isEmpty;

    if (isEmptyPassword) return const SizedBox.shrink();

    return Row(
      children: [
        if (getProgressColor() == Colors.green)
          Lottie.asset(
            AppLottie.checkboxCircle,
            width: 30,
            height: 30,
            fit: BoxFit.cover,
            frameRate: const FrameRate(60.0),
            repeat: false,
            animate: true,
          ),
        if (getProgressColor() == Colors.green)
          Expanded(
            child: MainText(
              text: getPasswordStrengthMessage(),
              style: AppTextStyles.bodyXXsReq.copyWith(
                color: AppColors.kGeryText5,
              ),
            ),
          ),
        if (getProgressColor() != Colors.green)
          MainText(
            text: ' • ',
            style: AppTextStyles.bodyXXsReq.copyWith(
              color: AppColors.kGeryText5,
            ),
          ),
        if (getProgressColor() != Colors.green)
          Expanded(
            child: MainText(
              text: PasswordValidator.passwordValidator(widget.password),
              style: AppTextStyles.bodyXXsReq.copyWith(
                color: AppColors.kGeryText5,
              ),
            ),
            // MainText(
            //   text: 'Password Strength: ${getPasswordStrengthMessage()}',
            //   fontSize: 14,
            //   fontWeight: FontWeight.w500,
            //   color: getProgressColor(),
            // ),
          ),

        // Progress Indicator
        SizedBox(
          width: 100,
          child: SegmentedStrengthIndicator(
            strength: getPasswordStrengthProgress(),
            height: 4,
            borderRadius: 4,
            segmentSpacing: 2,
          ),
          //  LinearProgressIndicator(
          //   value: getPasswordStrengthProgress(),
          //   backgroundColor: Colors.grey[200],
          //   valueColor: AlwaysStoppedAnimation<Color>(getProgressColor()),
          //   minHeight: 8,
          //   borderRadius: BorderRadius.circular(4),
          // ),
        ),
      ],
    );
  }
}

class SegmentedStrengthIndicator extends StatelessWidget {
  final double strength; // Value between 0 and 1
  final int segmentCount;
  final double segmentSpacing;
  final double height;
  final double borderRadius;

  const SegmentedStrengthIndicator({
    super.key,
    required this.strength,
    this.segmentCount = 4,
    this.segmentSpacing = 2,
    this.height = 8,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        children: List.generate(segmentCount, (index) {
          // Calculate if this segment should be filled
          final segmentValue = (index + 1) / segmentCount;
          final isFilled = strength >= segmentValue;
          final isPartial =
              strength > (index / segmentCount) && strength < segmentValue;
          final fillPercentage = isPartial
              ? (strength - (index / segmentCount)) * segmentCount
              : 0;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  right: index == segmentCount - 1 ? 0 : segmentSpacing),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      color: Colors.grey[200],
                    ),
                    if (isFilled || isPartial)
                      Container(
                        height: height,
                        width: isFilled
                            ? double.infinity.toDouble()
                            : fillPercentage.toDouble(),
                        color: AppColors.kPrimary500,
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
