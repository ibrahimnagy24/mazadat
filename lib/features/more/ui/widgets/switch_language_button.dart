import 'package:flutter/material.dart';

import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/restart_widget.dart';

class SwitchLanguageButton extends StatelessWidget {
  const SwitchLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: mainAppBloc.langStream,
        builder: (context, snapshot) {
          return Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.kPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.rM),
            ),
            child: ToggleButtons(
              direction: Axis.horizontal,
              isSelected: [
                (snapshot.data ?? 'en') == LangKeysConstances.en.name,
                (snapshot.data ?? 'ar') == LangKeysConstances.ar.name,
              ],
              onPressed: (index) async {
                await mainAppBloc
                    .setLanguage(LangKeysConstances.values[index].name);
                RestartWidget.restartApp(context);
              },
              borderRadius: BorderRadius.circular(AppRadius.rXS),
              renderBorder: true, // ✅ Ensures borders are shown
              selectedBorderColor: AppColors.kPrimary,
              borderColor: AppColors.transparent,
              selectedColor: AppColors.kPrimary,
              fillColor: AppColors.kPrimary,
              constraints: BoxConstraints(
                minHeight: 25.w,
                minWidth: 40.w,
              ),
              children: [
                Text(
                  'EN',
                  style: AppTextStyles.textLgRegular.copyWith(
                    color: snapshot.data == LangKeysConstances.en.name
                        ? AppColors.kWhite
                        : AppColors.kPrimary,
                  ),
                ),
                Text(
                  'ع',
                  style: AppTextStyles.textLgRegular.copyWith(
                    color: snapshot.data == LangKeysConstances.ar.name
                        ? AppColors.kWhite
                        : AppColors.kPrimary,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
