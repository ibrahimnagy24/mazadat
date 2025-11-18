import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/widgets/misc/restart_widget.dart';

class SwitchLanguageButton extends StatelessWidget {
  const SwitchLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: mainAppBloc.langStream,
      builder: (context, snapshot) {
        final currentLang = snapshot.data ?? 'en';
        final isEnglish = currentLang == LangKeysConstances.en.name;
        final isArabic = currentLang == LangKeysConstances.ar.name;

        return Container(
          height: 50,
          width: 90,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(238, 239, 235, 1),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Row(
            children: [
              // English Button
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (!isEnglish) {
                      await mainAppBloc.setLanguage(LangKeysConstances.en.name);
                      RestartWidget.restartApp(context);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isEnglish
                          ? AppColors.kPrimary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      style: AppTextStyles.textLgRegular.copyWith(
                        color: isEnglish
                            ? AppColors.kWhite
                            : AppColors.kPrimary,
                        fontWeight: isEnglish
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      child: const Text('EN', textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 2),

              // Arabic Button
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (!isArabic) {
                      await mainAppBloc.setLanguage(LangKeysConstances.ar.name);
                      RestartWidget.restartApp(context);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isArabic ? AppColors.kPrimary : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      style: AppTextStyles.textLgRegular.copyWith(
                        color: isArabic ? AppColors.kWhite : AppColors.kPrimary,
                        fontWeight: isArabic
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(bottom: 6),
                        child: Text(
                          'ع',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            color: isArabic
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(81, 94, 50, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
