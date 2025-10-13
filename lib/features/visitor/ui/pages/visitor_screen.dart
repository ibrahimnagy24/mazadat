import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
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
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Logo with smooth animation
                          Image.asset(
                            AppImages.baitElasjadiahVisitorLogo,
                            height: 120,
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
                            style:
                                AppTextStyles.textMdSemiboldIbmPlexSansArabic,
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
                            style: AppTextStyles.textLgMedium,
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

                    16.sbH,

                    // Additional Info
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(254, 252, 245, 1),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color.fromRGBO(249, 239, 209, 1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppSvg.policyGuard,
                            height: 20,
                            width: 20,
                          ),
                          8.sbW,
                          MainText(
                            text: AppStrings.secureTrustedPlatform.tr,
                            style: GoogleFonts.cairo(
                              color: AppColors.kPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
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
      fontSize: fontSize,
      height: 48,
      textStyle: AppTextStyles.bodyXlBold
          .copyWith(color: const Color.fromRGBO(255, 255, 255, 1)),
      elevation: 0,
    );
  }

  Widget _buildEnhancedRegisterButton(BuildContext context,
      {final double? fontSize}) {
    return DefaultButton(
      onPressed: () {
        CustomNavigator.push(Routes.REGISTER_SCREEN);
      },
      text: AppStrings.registerAndStart.tr,
      fontSize: fontSize ?? (Responsive.isSmall(context) ? 16 : 18),
      height: 48,
      textStyle: AppTextStyles.bodyXlBold
          .copyWith(color: const Color.fromRGBO(81, 94, 50, 1)),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
