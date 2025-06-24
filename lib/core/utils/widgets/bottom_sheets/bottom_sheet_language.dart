// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';

import '../../enums/enums.dart';
import '../buttons/custom_gradient_button_widget.dart';
import '../misc/restart_widget.dart';

class BottomSheetLanguage extends StatelessWidget {
  const BottomSheetLanguage({
    super.key,
    required this.modalContext,
  });
  final BuildContext modalContext;
  @override
  Widget build(BuildContext context) {
    String selectedLang = mainAppBloc.globalLang;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          color: AppColors.kWhite,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'AppStrings.changeLanguage.tr',
                          style: AppTextStyles
                              .balooBhaijaan2W600Size14KPrimary1000,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(modalContext);
                          },
                          icon: const Icon(
                            CupertinoIcons.xmark,
                            color: AppColors.kBlack,
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'English',
                      style: AppTextStyles.balooBhaijaan2W400Size14KPrimary1000,
                    ),
                    trailing: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.kPrimary700),
                        color: selectedLang == LangKeysConstances.en.name
                            ? AppColors.kPrimary700
                            : AppColors.kWhite,
                      ),
                      child: selectedLang == LangKeysConstances.en.name
                          ? const Icon(
                              CupertinoIcons.check_mark,
                              color: AppColors.kWhite,
                              size: 12,
                            )
                          : null,
                    ),
                    onTap: () {
                      if (selectedLang != LangKeysConstances.en.name) {
                        setState(
                            () => selectedLang = LangKeysConstances.en.name);
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                      'العربية',
                      style: AppTextStyles.balooBhaijaan2W400Size14KPrimary1000,
                    ),
                    trailing: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.kPrimary700),
                        color: selectedLang == LangKeysConstances.ar.name
                            ? AppColors.kPrimary700
                            : AppColors.kWhite,
                      ),
                      child: selectedLang == LangKeysConstances.ar.name
                          ? const Icon(
                              CupertinoIcons.check_mark,
                              color: AppColors.kWhite,
                              size: 12,
                            )
                          : null,
                    ),
                    onTap: () {
                      if (selectedLang != LangKeysConstances.ar.name) {
                        setState(
                            () => selectedLang = LangKeysConstances.ar.name);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomGradientButtonWidget(
                      text: 'AppStrings.changeLanguage.tr',
                      isActive: selectedLang != mainAppBloc.globalLang,
                      onPressed: () async {
                        await mainAppBloc.setLanguage(selectedLang);
                        RestartWidget.restartApp(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
