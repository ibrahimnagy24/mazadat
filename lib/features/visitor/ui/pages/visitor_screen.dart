import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/custom_button_with_inner_shadow_widget.dart';
import '../../../../core/utils/widgets/buttons/custom_gradient_button_widget.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/responsive/responsive.dart';
import '../../../../core/utils/widgets/text/main_text.dart';

class VisitorScreen extends StatelessWidget {
  const VisitorScreen({super.key, this.fontSize});
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.scaffoldBackground,
            AppColors.backgroundBody,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Header Section
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Welcome Card
                    Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.kPrimary.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Logo with smooth animation
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundSecondary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SvgPicture.asset(
                              AppSvg.logo,
                              height: 120,
                            ),
                          )
                              .animate()
                              .fadeIn(
                                duration: 800.ms,
                                curve: Curves.easeOutCubic,
                              )
                              .slideY(
                                begin: -0.1,
                                duration: 800.ms,
                                curve: Curves.easeOutCubic,
                              ),

                          24.sbH,

                          // Welcome Text
                          MainText(
                            text: AppStrings.welcomeToMazadat.tr,
                            style: AppTextStyles
                                .balooBhaijaan2W700Size24Primary1000
                                .copyWith(
                              fontSize: Responsive.isSmall(context) ? 22 : 24,
                              color: AppColors.kPrimary,
                            ),
                            textAlign: TextAlign.center,
                          )
                              .animate(delay: 200.ms)
                              .fadeIn(
                                duration: 600.ms,
                                curve: Curves.easeOut,
                              )
                              .slideY(
                                begin: 0.2,
                                duration: 600.ms,
                                curve: Curves.easeOut,
                              ),

                          16.sbH,

                          MainText(
                            text: AppStrings
                                .joinOurCommunityToEnjoyExcitingAuctionsAndConnectWithFriendsAlreadyHaveAnAccountWelcomeBack
                                .tr,
                            style: AppTextStyles
                                .balooBhaijaan2W400Size16kPrimary700
                                .copyWith(
                              fontSize: fontSize ??
                                  (Responsive.isSmall(context) ? 14 : 16),
                              color: AppColors.textPrimaryParagraph,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          )
                              .animate(delay: 400.ms)
                              .fadeIn(
                                duration: 600.ms,
                                curve: Curves.easeOut,
                              )
                              .slideY(
                                begin: 0.2,
                                duration: 600.ms,
                                curve: Curves.easeOut,
                              ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(
                          duration: 700.ms,
                          curve: Curves.easeOutCubic,
                        )
                        .slideY(
                          begin: 0.1,
                          duration: 700.ms,
                          curve: Curves.easeOutCubic,
                        ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (Responsive.isSmall(context))
                      Column(
                        children: [
                          _buildEnhancedLoginButton(context,
                              fontSize: fontSize),
                          20.sbH,
                          _buildEnhancedRegisterButton(context,
                              fontSize: fontSize),
                        ],
                      )
                          .animate(delay: 600.ms)
                          .fadeIn(
                            duration: 500.ms,
                            curve: Curves.easeOut,
                          )
                          .slideY(
                            begin: 0.1,
                            duration: 500.ms,
                            curve: Curves.easeOut,
                          ),
                    if (!Responsive.isSmall(context))
                      Row(
                        children: [
                          Expanded(
                              child: _buildEnhancedLoginButton(context,
                                  fontSize: fontSize)),
                          20.sbW,
                          Expanded(
                              child: _buildEnhancedRegisterButton(context,
                                  fontSize: fontSize)),
                        ],
                      )
                          .animate(delay: 600.ms)
                          .fadeIn(
                            duration: 500.ms,
                            curve: Curves.easeOut,
                          )
                          .slideY(
                            begin: 0.1,
                            duration: 500.ms,
                            curve: Curves.easeOut,
                          ),

                    32.sbH,

                    // Additional Info
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.borderSecondary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.security_rounded,
                            color: AppColors.kPrimary,
                            size: 16,
                          ),
                          8.sbW,
                          MainText(
                            text: AppStrings.secureTrustedPlatform.tr,
                            style: AppTextStyles
                                .balooBhaijaan2W500Size12KPrimary700
                                .copyWith(
                              color: AppColors.kPrimary,
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate(delay: 800.ms)
                        .fadeIn(
                          duration: 400.ms,
                          curve: Curves.easeOut,
                        )
                        .slideY(
                          begin: 0.1,
                          duration: 400.ms,
                          curve: Curves.easeOut,
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedLoginButton(BuildContext context,
      {final double? fontSize}) {
    return DefaultButton(
      onPressed: () {
        CustomNavigator.push(Routes.LOGIN_SCREEN);
      },
      text: AppStrings.login.tr,
      fontSize: fontSize ?? (Responsive.isSmall(context) ? 16 : 18),
      height: 56,
      textStyle: AppTextStyles.balooBhaijaan2W600Size18White.copyWith(
        fontSize: fontSize ?? (Responsive.isSmall(context) ? 16 : 18),
      ),
    );
  }

  Widget _buildEnhancedRegisterButton(BuildContext context,
      {final double? fontSize}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimary.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CustomButtonWithInnerShadowWidget(
        onPressed: () {
          CustomNavigator.push(Routes.REGISTER_SCREEN);
        },
        text: AppStrings.registerAndStart.tr,
        fontSize: fontSize ?? (Responsive.isSmall(context) ? 16 : 18),
        height: 56,
        borderRadiousValue: 8,
        color: AppColors.kWhite,
        textStyle: AppTextStyles.balooBhaijaan2W600Size16KPrimary1000.copyWith(
          fontSize: fontSize ?? (Responsive.isSmall(context) ? 16 : 18),
          color: AppColors.kPrimary,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.backgroundSecondary.withOpacity(0.3),
            offset: const Offset(-2, -2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.backgroundSecondary.withOpacity(0.2),
            offset: const Offset(2, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }

  // Legacy methods for backward compatibility
  Widget loginButton({final double? fontSize}) {
    return DefaultButton(
      onPressed: () {
        CustomNavigator.push(Routes.LOGIN_SCREEN);
      },
      text: AppStrings.login.tr,
      fontSize: fontSize,
      backgroundColor: AppColors.kPrimary,
      borderColor: AppColors.kPrimary,
    );
  }

  Widget registerButton({final double? fontSize}) {
    return CustomButtonWithInnerShadowWidget(
      onPressed: () {
        CustomNavigator.push(Routes.REGISTER_SCREEN);
      },
      text: AppStrings.registerAndStart.tr,
      fontSize: fontSize,
    );
  }
}
